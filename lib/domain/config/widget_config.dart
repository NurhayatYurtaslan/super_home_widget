/// Domain model for widget configuration.
/// 
/// Represents the configuration for a single widget instance.
library;

import '../models/widget_size.dart';
import '../models/widget_layout.dart';

/// Domain model representing a widget's configuration.
/// 
/// Contains all configuration values needed to create and render a widget:
/// - Widget size and layout
/// - Style type
/// - Refresh interval
class WidgetConfig {
  /// The size of the widget.
  final WidgetSize size;

  /// The layout style for the widget.
  final WidgetLayout layout;

  /// The style type name (e.g., 'liquidGlass').
  final String style;

  /// Refresh interval in seconds.
  final int refreshInterval;

  /// Creates a new [WidgetConfig] instance.
  const WidgetConfig({
    required this.size,
    required this.layout,
    required this.style,
    required this.refreshInterval,
  });

  /// Creates a [WidgetConfig] from a JSON map.
  factory WidgetConfig.fromJson(Map<String, dynamic> json) {
    return WidgetConfig(
      size: WidgetSize.fromString(json['size'] as String?) ?? WidgetSize.small,
      layout: WidgetLayout.fromString(json['layout'] as String?) ??
          WidgetLayout.compact,
      style: json['style'] as String? ?? 'liquidGlass',
      refreshInterval: json['refreshInterval'] as int? ?? 3600,
    );
  }

  /// Converts this [WidgetConfig] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'size': size.toValue(),
      'layout': layout.toValue(),
      'style': style,
      'refreshInterval': refreshInterval,
    };
  }
}

