/// Domain model for widget sizes.
/// 
/// Defines the standard iOS widget sizes supported by WidgetKit.
library;

/// Enumeration of available widget sizes.
/// 
/// iOS WidgetKit supports three standard widget sizes:
/// - [small]: 2x2 grid cells (~155x155pt on iPhone)
/// - [medium]: 4x2 grid cells (~329x155pt on iPhone)
/// - [large]: 4x4 grid cells (~329x345pt on iPhone)
enum WidgetSize {
  /// Small widget (2x2 grid cells).
  small,

  /// Medium widget (4x2 grid cells).
  medium,

  /// Large widget (4x4 grid cells).
  large;

  /// Creates a [WidgetSize] from a string value.
  /// 
  /// Returns `null` if the string doesn't match any enum value.
  static WidgetSize? fromString(String? value) {
    if (value == null) return null;
    switch (value.toLowerCase()) {
      case 'small':
        return WidgetSize.small;
      case 'medium':
        return WidgetSize.medium;
      case 'large':
        return WidgetSize.large;
      default:
        return null;
    }
  }

  /// Converts this [WidgetSize] to a string value.
  String toValue() {
    switch (this) {
      case WidgetSize.small:
        return 'small';
      case WidgetSize.medium:
        return 'medium';
      case WidgetSize.large:
        return 'large';
    }
  }
}

