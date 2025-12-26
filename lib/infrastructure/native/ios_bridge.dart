/// iOS native bridge for widget communication.
/// 
/// Handles all communication between Flutter and iOS native code
/// for widget operations.
library;

import 'dart:async';
import 'package:flutter/services.dart';
import '../../domain/models/widget_data.dart';

/// iOS bridge singleton for native communication.
/// 
/// Provides methods for:
/// - Widget data updates
/// - Widget refresh
/// - App Group container access
/// - Widget click event handling
class IOSBridge {
  /// Method channel for Flutter → Native communication.
  static const MethodChannel _methodChannel = MethodChannel(
    'com.superhomewidget/widget',
  );

  /// Event channel for Native → Flutter communication.
  static const EventChannel _eventChannel = EventChannel(
    'com.superhomewidget/events',
  );

  /// Singleton instance.
  static IOSBridge? _instance;

  /// Stream of widget click events.
  Stream<Map<String, dynamic>>? _clickEvents;

  /// Private constructor for singleton pattern.
  IOSBridge._();

  /// Gets the singleton instance.
  factory IOSBridge() {
    _instance ??= IOSBridge._();
    return _instance!;
  }

  /// Initializes the bridge with app group ID.
  /// 
  /// [appGroupId] is the App Group identifier for shared container.
  Future<void> initialize({required String appGroupId}) async {
    try {
      await _methodChannel.invokeMethod('initialize', {
        'appGroupId': appGroupId,
      });
    } catch (e) {
      throw Exception('Failed to initialize iOS bridge: $e');
    }
  }

  /// Updates widget data.
  /// 
  /// [data] is the widget data to update.
  /// [widgetSize] is the size of the widget ('small', 'medium', or 'large').
  Future<void> updateWidgetData({
    required WidgetData data,
    required String widgetSize,
  }) async {
    try {
      await _methodChannel.invokeMethod('updateWidgetData', {
        'data': data.toJson(),
        'widgetSize': widgetSize,
      });
    } catch (e) {
      throw Exception('Failed to update widget data: $e');
    }
  }

  /// Refreshes all widgets.
  /// 
  /// Forces a refresh of all widget timelines.
  Future<void> refreshAllWidgets() async {
    try {
      await _methodChannel.invokeMethod('refreshAllWidgets');
    } catch (e) {
      throw Exception('Failed to refresh widgets: $e');
    }
  }

  /// Refreshes a specific widget.
  /// 
  /// [widgetSize] is the size of the widget to refresh.
  Future<void> refreshWidget({required String widgetSize}) async {
    try {
      await _methodChannel.invokeMethod('refreshWidget', {
        'widgetSize': widgetSize,
      });
    } catch (e) {
      throw Exception('Failed to refresh widget: $e');
    }
  }

  /// Gets the stream of widget click events.
  /// 
  /// Returns a stream that emits events when widgets are clicked.
  Stream<Map<String, dynamic>> getClickEvents() {
    _clickEvents ??= _eventChannel
        .receiveBroadcastStream()
        .map((event) => Map<String, dynamic>.from(event as Map));
    return _clickEvents!;
  }

  /// Saves widget configuration to App Group container.
  /// 
  /// [config] is the configuration map to save.
  Future<void> saveConfig(Map<String, dynamic> config) async {
    try {
      await _methodChannel.invokeMethod('saveConfig', {
        'config': config,
      });
    } catch (e) {
      throw Exception('Failed to save config: $e');
    }
  }

  /// Loads widget configuration from App Group container.
  /// 
  /// Returns the configuration map, or `null` if not found.
  Future<Map<String, dynamic>?> loadConfig() async {
    try {
      final result = await _methodChannel.invokeMethod('loadConfig');
      return result != null
          ? Map<String, dynamic>.from(result as Map)
          : null;
    } catch (e) {
      throw Exception('Failed to load config: $e');
    }
  }
}

