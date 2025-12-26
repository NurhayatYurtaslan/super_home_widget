import Flutter
import UIKit

#if canImport(WidgetKit)
import WidgetKit
#endif

/// Flutter plugin for Super Home Widget
public class SuperHomeWidgetPlugin: NSObject, FlutterPlugin {
    /// Method channel name
    private static let methodChannelName = "com.superhomewidget/widget"
    
    /// Event channel name
    private static let eventChannelName = "com.superhomewidget/events"
    
    /// App Group ID (set during initialization)
    private var appGroupId: String?
    
    /// Event sink for widget click events
    private var eventSink: FlutterEventSink?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: methodChannelName,
            binaryMessenger: registrar.messenger()
        )
        
        let instance = SuperHomeWidgetPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        // Register event channel
        let eventChannel = FlutterEventChannel(
            name: eventChannelName,
            binaryMessenger: registrar.messenger()
        )
        eventChannel.setStreamHandler(instance)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize":
            handleInitialize(call: call, result: result)
        case "updateWidgetData":
            handleUpdateWidgetData(call: call, result: result)
        case "refreshAllWidgets":
            handleRefreshAllWidgets(result: result)
        case "refreshWidget":
            handleRefreshWidget(call: call, result: result)
        case "saveConfig":
            handleSaveConfig(call: call, result: result)
        case "loadConfig":
            handleLoadConfig(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    // MARK: - Method Handlers
    
    private func handleInitialize(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let appGroupId = args["appGroupId"] as? String else {
            result(FlutterError(
                code: "INVALID_ARGUMENT",
                message: "appGroupId is required",
                details: nil
            ))
            return
        }
        
        self.appGroupId = appGroupId
        result(nil)
    }
    
    private func handleUpdateWidgetData(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let appGroupId = appGroupId else {
            result(FlutterError(
                code: "NOT_INITIALIZED",
                message: "Plugin not initialized. Call initialize first.",
                details: nil
            ))
            return
        }
        
        guard let args = call.arguments as? [String: Any],
              let data = args["data"] as? [String: Any],
              let widgetSize = args["widgetSize"] as? String else {
            result(FlutterError(
                code: "INVALID_ARGUMENT",
                message: "data and widgetSize are required",
                details: nil
            ))
            return
        }
        
        guard let userDefaults = UserDefaults(suiteName: appGroupId) else {
            result(FlutterError(
                code: "APP_GROUP_ERROR",
                message: "Failed to access App Group container",
                details: nil
            ))
            return
        }
        
        // Save widget data to App Group
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            userDefaults.set(jsonData, forKey: "widgetData")
            userDefaults.synchronize()
            
            // Reload widget timelines
            #if canImport(WidgetKit)
            if #available(iOS 14.0, *) {
                WidgetCenter.shared.reloadTimelines(ofKind: "SuperHomeWidget")
            }
            #endif
            
            result(nil)
        } catch {
            result(FlutterError(
                code: "SERIALIZATION_ERROR",
                message: "Failed to serialize widget data: \(error.localizedDescription)",
                details: nil
            ))
        }
    }
    
    private func handleRefreshAllWidgets(result: @escaping FlutterResult) {
        #if canImport(WidgetKit)
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
            result(nil)
        } else {
            result(FlutterError(
                code: "UNSUPPORTED_VERSION",
                message: "WidgetKit requires iOS 14.0+",
                details: nil
            ))
        }
        #else
        result(FlutterError(
            code: "UNSUPPORTED_VERSION",
            message: "WidgetKit is not available",
            details: nil
        ))
        #endif
    }
    
    private func handleRefreshWidget(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let widgetSize = args["widgetSize"] as? String else {
            result(FlutterError(
                code: "INVALID_ARGUMENT",
                message: "widgetSize is required",
                details: nil
            ))
            return
        }
        
        #if canImport(WidgetKit)
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadTimelines(ofKind: "SuperHomeWidget")
            result(nil)
        } else {
            result(FlutterError(
                code: "UNSUPPORTED_VERSION",
                message: "WidgetKit requires iOS 14.0+",
                details: nil
            ))
        }
        #else
        result(FlutterError(
            code: "UNSUPPORTED_VERSION",
            message: "WidgetKit is not available",
            details: nil
        ))
        #endif
    }
    
    private func handleSaveConfig(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let appGroupId = appGroupId else {
            result(FlutterError(
                code: "NOT_INITIALIZED",
                message: "Plugin not initialized. Call initialize first.",
                details: nil
            ))
            return
        }
        
        guard let args = call.arguments as? [String: Any],
              let config = args["config"] as? [String: Any] else {
            result(FlutterError(
                code: "INVALID_ARGUMENT",
                message: "config is required",
                details: nil
            ))
            return
        }
        
        guard let userDefaults = UserDefaults(suiteName: appGroupId) else {
            result(FlutterError(
                code: "APP_GROUP_ERROR",
                message: "Failed to access App Group container",
                details: nil
            ))
            return
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: config, options: [])
            userDefaults.set(jsonData, forKey: "widgetConfig")
            userDefaults.synchronize()
            
            result(nil)
        } catch {
            result(FlutterError(
                code: "SERIALIZATION_ERROR",
                message: "Failed to serialize config: \(error.localizedDescription)",
                details: nil
            ))
        }
    }
    
    private func handleLoadConfig(result: @escaping FlutterResult) {
        guard let appGroupId = appGroupId else {
            result(FlutterError(
                code: "NOT_INITIALIZED",
                message: "Plugin not initialized. Call initialize first.",
                details: nil
            ))
            return
        }
        
        guard let userDefaults = UserDefaults(suiteName: appGroupId),
              let jsonData = userDefaults.data(forKey: "widgetConfig"),
              let config = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
            result(nil)
            return
        }
        
        result(config)
    }
}

// MARK: - FlutterStreamHandler

extension SuperHomeWidgetPlugin: FlutterStreamHandler {
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
}

