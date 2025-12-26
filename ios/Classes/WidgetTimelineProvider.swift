import WidgetKit
import SwiftUI

/// Entry for widget timeline
@available(iOS 14.0, *)
struct SuperHomeWidgetEntry: TimelineEntry {
    let date: Date
    let widgetData: WidgetDataModel
    let styleConfig: StyleConfigModel
    let size: WidgetFamily
}

/// Widget data model
struct WidgetDataModel {
    var title: String?
    var subtitle: String?
    var body: String?
    var imageUrl: String?
    var iconName: String?
    var customData: [String: Any]?
    
    init() {
        self.title = nil
        self.subtitle = nil
        self.body = nil
        self.imageUrl = nil
        self.iconName = nil
        self.customData = nil
    }
    
    init(from dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String
        self.subtitle = dictionary["subtitle"] as? String
        self.body = dictionary["body"] as? String
        self.imageUrl = dictionary["imageUrl"] as? String
        self.iconName = dictionary["iconName"] as? String
        self.customData = dictionary["customData"] as? [String: Any]
    }
}

/// Style configuration model
struct StyleConfigModel {
    var styleName: String
    var backgroundColor: String
    var backgroundOpacity: Double
    var cornerRadius: Double
    var blurRadius: Double?
    var fontFamily: String
    var titleSize: Double
    var bodySize: Double
    var captionSize: Double
    var primaryColor: String
    var secondaryColor: String
    var textColor: String
    var textSecondaryColor: String
    var shadowEnabled: Bool
    var shadowOpacity: Double
    var shadowRadius: Double
    var borderEnabled: Bool
    var borderWidth: Double
    var borderColor: String
    var borderOpacity: Double
    var gradientEnabled: Bool
    var gradientColors: [String]
    var gradientAngle: Double
    var highlightsEnabled: Bool
    var highlightsOpacity: Double
    
    static var defaultStyle: StyleConfigModel {
        return StyleConfigModel(
            styleName: "default",
            backgroundColor: "#FFFFFF",
            backgroundOpacity: 1.0,
            cornerRadius: 16,
            blurRadius: nil,
            fontFamily: "SF Pro",
            titleSize: 20,
            bodySize: 14,
            captionSize: 12,
            primaryColor: "#007AFF",
            secondaryColor: "#5856D6",
            textColor: "#000000",
            textSecondaryColor: "#8E8E93",
            shadowEnabled: true,
            shadowOpacity: 0.1,
            shadowRadius: 8,
            borderEnabled: false,
            borderWidth: 0,
            borderColor: "#FFFFFF",
            borderOpacity: 0,
            gradientEnabled: false,
            gradientColors: [],
            gradientAngle: 0,
            highlightsEnabled: false,
            highlightsOpacity: 0
        )
    }
    
    static var liquidGlassStyle: StyleConfigModel {
        return StyleConfigModel(
            styleName: "liquidGlass",
            backgroundColor: "#FFFFFF",
            backgroundOpacity: 0.85,
            cornerRadius: 20,
            blurRadius: 20,
            fontFamily: "SF Pro Rounded",
            titleSize: 22,
            bodySize: 15,
            captionSize: 13,
            primaryColor: "#00D9FF",
            secondaryColor: "#FF6B9D",
            textColor: "#FFFFFF",
            textSecondaryColor: "#FFFFFF80",
            shadowEnabled: true,
            shadowOpacity: 0.2,
            shadowRadius: 12,
            borderEnabled: true,
            borderWidth: 1.5,
            borderColor: "#FFFFFF",
            borderOpacity: 0.3,
            gradientEnabled: true,
            gradientColors: ["#00D9FF20", "#FF6B9D20"],
            gradientAngle: 135,
            highlightsEnabled: true,
            highlightsOpacity: 0.4
        )
    }
    
    init(from dictionary: [String: Any]) {
        self.styleName = dictionary["styleName"] as? String ?? "default"
        
        // Background
        if let background = dictionary["background"] as? [String: Any] {
            self.backgroundColor = background["color"] as? String ?? "#FFFFFF"
            self.backgroundOpacity = background["opacity"] as? Double ?? 1.0
            self.blurRadius = background["blurRadius"] as? Double
        } else {
            self.backgroundColor = "#FFFFFF"
            self.backgroundOpacity = 1.0
            self.blurRadius = nil
        }
        
        self.cornerRadius = dictionary["cornerRadius"] as? Double ?? 16
        
        // Typography
        if let typography = dictionary["typography"] as? [String: Any] {
            self.fontFamily = typography["fontFamily"] as? String ?? "SF Pro"
            self.titleSize = typography["titleSize"] as? Double ?? 20
            self.bodySize = typography["bodySize"] as? Double ?? 14
            self.captionSize = typography["captionSize"] as? Double ?? 12
        } else {
            self.fontFamily = "SF Pro"
            self.titleSize = 20
            self.bodySize = 14
            self.captionSize = 12
        }
        
        // Colors
        if let colors = dictionary["colors"] as? [String: Any] {
            self.primaryColor = colors["primary"] as? String ?? "#007AFF"
            self.secondaryColor = colors["secondary"] as? String ?? "#5856D6"
            self.textColor = colors["text"] as? String ?? "#000000"
            self.textSecondaryColor = colors["textSecondary"] as? String ?? "#8E8E93"
        } else {
            self.primaryColor = "#007AFF"
            self.secondaryColor = "#5856D6"
            self.textColor = "#000000"
            self.textSecondaryColor = "#8E8E93"
        }
        
        // Shadows
        if let shadows = dictionary["shadows"] as? [String: Any] {
            self.shadowEnabled = shadows["enabled"] as? Bool ?? true
            self.shadowOpacity = shadows["opacity"] as? Double ?? 0.1
            self.shadowRadius = shadows["radius"] as? Double ?? 8
        } else {
            self.shadowEnabled = true
            self.shadowOpacity = 0.1
            self.shadowRadius = 8
        }
        
        // Border
        if let border = dictionary["border"] as? [String: Any] {
            self.borderEnabled = border["enabled"] as? Bool ?? false
            self.borderWidth = border["width"] as? Double ?? 0
            self.borderColor = border["color"] as? String ?? "#FFFFFF"
            self.borderOpacity = border["opacity"] as? Double ?? 0
        } else {
            self.borderEnabled = false
            self.borderWidth = 0
            self.borderColor = "#FFFFFF"
            self.borderOpacity = 0
        }
        
        // Gradient
        if let gradient = dictionary["gradient"] as? [String: Any] {
            self.gradientEnabled = gradient["enabled"] as? Bool ?? false
            self.gradientColors = gradient["colors"] as? [String] ?? []
            self.gradientAngle = gradient["angle"] as? Double ?? 135
        } else {
            self.gradientEnabled = false
            self.gradientColors = []
            self.gradientAngle = 135
        }
        
        // Highlights
        if let highlights = dictionary["highlights"] as? [String: Any] {
            self.highlightsEnabled = highlights["enabled"] as? Bool ?? false
            self.highlightsOpacity = highlights["opacity"] as? Double ?? 0
        } else {
            self.highlightsEnabled = false
            self.highlightsOpacity = 0
        }
    }
    
    init(styleName: String, backgroundColor: String, backgroundOpacity: Double,
         cornerRadius: Double, blurRadius: Double?, fontFamily: String,
         titleSize: Double, bodySize: Double, captionSize: Double,
         primaryColor: String, secondaryColor: String, textColor: String,
         textSecondaryColor: String, shadowEnabled: Bool, shadowOpacity: Double,
         shadowRadius: Double, borderEnabled: Bool, borderWidth: Double,
         borderColor: String, borderOpacity: Double, gradientEnabled: Bool,
         gradientColors: [String], gradientAngle: Double, highlightsEnabled: Bool,
         highlightsOpacity: Double) {
        self.styleName = styleName
        self.backgroundColor = backgroundColor
        self.backgroundOpacity = backgroundOpacity
        self.cornerRadius = cornerRadius
        self.blurRadius = blurRadius
        self.fontFamily = fontFamily
        self.titleSize = titleSize
        self.bodySize = bodySize
        self.captionSize = captionSize
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.textColor = textColor
        self.textSecondaryColor = textSecondaryColor
        self.shadowEnabled = shadowEnabled
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius
        self.borderEnabled = borderEnabled
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.borderOpacity = borderOpacity
        self.gradientEnabled = gradientEnabled
        self.gradientColors = gradientColors
        self.gradientAngle = gradientAngle
        self.highlightsEnabled = highlightsEnabled
        self.highlightsOpacity = highlightsOpacity
    }
}

/// Timeline provider for Super Home Widget
@available(iOS 14.0, *)
struct SuperHomeWidgetTimelineProvider: TimelineProvider {
    typealias Entry = SuperHomeWidgetEntry
    
    let appGroupId: String
    let widgetSize: WidgetFamily
    
    init(appGroupId: String, widgetSize: WidgetFamily) {
        self.appGroupId = appGroupId
        self.widgetSize = widgetSize
    }
    
    func placeholder(in context: Context) -> SuperHomeWidgetEntry {
        SuperHomeWidgetEntry(
            date: Date(),
            widgetData: WidgetDataModel(),
            styleConfig: getDefaultStyle(for: context.family),
            size: context.family
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SuperHomeWidgetEntry) -> Void) {
        let entry = createEntry(for: context.family)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SuperHomeWidgetEntry>) -> Void) {
        let entry = createEntry(for: context.family)
        let refreshInterval = getRefreshInterval(for: context.family)
        let nextUpdate = Calendar.current.date(byAdding: .second, value: refreshInterval, to: Date())!
        
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
    
    private func createEntry(for family: WidgetFamily) -> SuperHomeWidgetEntry {
        let widgetData = loadWidgetData()
        let styleConfig = loadStyleConfig(for: family)
        
        return SuperHomeWidgetEntry(
            date: Date(),
            widgetData: widgetData,
            styleConfig: styleConfig,
            size: family
        )
    }
    
    private func loadWidgetData() -> WidgetDataModel {
        // First try to load from UserDefaults (updated data)
        if let userDefaults = UserDefaults(suiteName: appGroupId),
           let jsonData = userDefaults.data(forKey: "widgetData"),
           let dictionary = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
            return WidgetDataModel(from: dictionary)
        }
        
        // Fallback to initial data from config
        if let userDefaults = UserDefaults(suiteName: appGroupId),
           let jsonData = userDefaults.data(forKey: "widgetConfig"),
           let config = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
           let data = config["data"] as? [String: Any],
           let initialData = data["initialData"] as? [String: Any] {
            return WidgetDataModel(from: initialData)
        }
        
        // Default fallback
        return WidgetDataModel(from: [
            "title": "Hello Widget",
            "subtitle": "Welcome to Super Home Widget",
            "body": "This is an example widget content.",
            "iconName": "star.fill"
        ])
    }
    
    private func loadStyleConfig(for family: WidgetFamily) -> StyleConfigModel {
        guard let userDefaults = UserDefaults(suiteName: appGroupId),
              let jsonData = userDefaults.data(forKey: "widgetConfig"),
              let config = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
              let styles = config["styles"] as? [String: Any],
              let widgets = config["widgets"] as? [String: Any] else {
            return getDefaultStyle(for: family)
        }
        
        // Get widget config for this size
        let sizeKey = getWidgetSizeKey(for: family)
        guard let widgetConfig = widgets[sizeKey] as? [String: Any],
              let styleName = widgetConfig["style"] as? String else {
            return getDefaultStyle(for: family)
        }
        
        // Get style config
        guard let styleDict = styles[styleName] as? [String: Any] else {
            return getDefaultStyle(for: family)
        }
        
        return StyleConfigModel(from: styleDict)
    }
    
    private func getDefaultStyle(for family: WidgetFamily) -> StyleConfigModel {
        switch family {
        case .systemSmall:
            return StyleConfigModel.defaultStyle
        case .systemMedium, .systemLarge:
            return StyleConfigModel.liquidGlassStyle
        default:
            return StyleConfigModel.defaultStyle
        }
    }
    
    private func getWidgetSizeKey(for family: WidgetFamily) -> String {
        switch family {
        case .systemSmall:
            return "small"
        case .systemMedium:
            return "medium"
        case .systemLarge:
            return "large"
        default:
            return "medium"
        }
    }
    
    private func getRefreshInterval(for family: WidgetFamily) -> Int {
        guard let userDefaults = UserDefaults(suiteName: appGroupId),
              let jsonData = userDefaults.data(forKey: "widgetConfig"),
              let config = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
              let widgets = config["widgets"] as? [String: Any] else {
            return 3600 // Default 1 hour
        }
        
        let sizeKey = getWidgetSizeKey(for: family)
        guard let widgetConfig = widgets[sizeKey] as? [String: Any],
              let refreshInterval = widgetConfig["refreshInterval"] as? Int else {
            return 3600
        }
        
        return refreshInterval
    }
}

