/// Domain model for widget dimensions.
/// 
/// Provides dimension constants for different widget sizes on iPhone and iPad.
library;

import 'widget_size.dart';

/// Value object containing widget dimensions.
/// 
/// Provides width and height values for widgets on different device types.
class WidgetDimensions {
  /// Width of the widget in points.
  final double width;

  /// Height of the widget in points.
  final double height;

  /// Creates a new [WidgetDimensions] instance.
  const WidgetDimensions({
    required this.width,
    required this.height,
  });

  /// Gets dimensions for a widget size on iPhone.
  /// 
  /// Returns the standard dimensions for the given [size] on iPhone.
  static WidgetDimensions forIPhone(WidgetSize size) {
    switch (size) {
      case WidgetSize.small:
        return const WidgetDimensions(width: 155, height: 155);
      case WidgetSize.medium:
        return const WidgetDimensions(width: 329, height: 155);
      case WidgetSize.large:
        return const WidgetDimensions(width: 329, height: 345);
    }
  }

  /// Gets dimensions for a widget size on iPad.
  /// 
  /// Returns the standard dimensions for the given [size] on iPad.
  static WidgetDimensions forIPad(WidgetSize size) {
    switch (size) {
      case WidgetSize.small:
        return const WidgetDimensions(width: 170, height: 170);
      case WidgetSize.medium:
        return const WidgetDimensions(width: 364, height: 170);
      case WidgetSize.large:
        return const WidgetDimensions(width: 364, height: 376);
    }
  }

  /// Converts this [WidgetDimensions] to a map.
  Map<String, double> toMap() {
    return {
      'width': width,
      'height': height,
    };
  }
}

