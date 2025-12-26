/// Enumeration of available widget style types.
library;

/// Enumeration of widget style types.
/// 
/// Currently only supports liquid glass style.
enum WidgetStyleType {
  /// Liquid glass style (glassmorphic effect).
  liquidGlass;

  /// Creates a [WidgetStyleType] from a string value.
  /// 
  /// Returns `null` if the string doesn't match any enum value.
  static WidgetStyleType? fromString(String? value) {
    if (value == null) return null;
    switch (value.toLowerCase()) {
      case 'liquidglass':
      case 'liquid_glass':
        return WidgetStyleType.liquidGlass;
      default:
        return null;
    }
  }

  /// Converts this [WidgetStyleType] to a string value.
  String toValue() {
    switch (this) {
      case WidgetStyleType.liquidGlass:
        return 'liquidGlass';
    }
  }
}

