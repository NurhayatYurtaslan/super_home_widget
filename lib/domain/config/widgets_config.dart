/// Domain model for widgets configuration.
/// 
/// Container for all widget configurations (small, medium, large).
library;

import 'widget_config.dart';
import '../models/widget_size.dart';

/// Domain model containing configurations for all widget sizes.
/// 
/// Provides access to configuration for small, medium, and large widgets.
class WidgetsConfig {
  /// Configuration for small widget.
  final WidgetConfig small;

  /// Configuration for medium widget.
  final WidgetConfig medium;

  /// Configuration for large widget.
  final WidgetConfig large;

  /// Creates a new [WidgetsConfig] instance.
  const WidgetsConfig({
    required this.small,
    required this.medium,
    required this.large,
  });

  /// Creates a [WidgetsConfig] from a JSON map.
  factory WidgetsConfig.fromJson(Map<String, dynamic> json) {
    return WidgetsConfig(
      small: WidgetConfig.fromJson({
        'size': 'small',
        ...json['small'] as Map<String, dynamic>? ?? {},
      }),
      medium: WidgetConfig.fromJson({
        'size': 'medium',
        ...json['medium'] as Map<String, dynamic>? ?? {},
      }),
      large: WidgetConfig.fromJson({
        'size': 'large',
        ...json['large'] as Map<String, dynamic>? ?? {},
      }),
    );
  }

  /// Converts this [WidgetsConfig] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'small': small.toJson(),
      'medium': medium.toJson(),
      'large': large.toJson(),
    };
  }

  /// Gets the configuration for a specific widget size.
  WidgetConfig getConfig(WidgetSize size) {
    switch (size) {
      case WidgetSize.small:
        return small;
      case WidgetSize.medium:
        return medium;
      case WidgetSize.large:
        return large;
    }
  }
}

