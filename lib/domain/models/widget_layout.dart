/// Domain model for widget layouts.
/// 
/// Defines the layout styles available for widgets.
library;

/// Enumeration of available widget layouts.
/// 
/// Different layouts provide different arrangements of content:
/// - [compact]: Minimal content arrangement for small widgets
/// - [expanded]: Moderate content arrangement for medium widgets
/// - [detailed]: Rich content arrangement for large widgets
enum WidgetLayout {
  /// Compact layout for minimal content.
  compact,

  /// Expanded layout for moderate content.
  expanded,

  /// Detailed layout for rich content.
  detailed;

  /// Creates a [WidgetLayout] from a string value.
  /// 
  /// Returns `null` if the string doesn't match any enum value.
  static WidgetLayout? fromString(String? value) {
    if (value == null) return null;
    switch (value.toLowerCase()) {
      case 'compact':
        return WidgetLayout.compact;
      case 'expanded':
        return WidgetLayout.expanded;
      case 'detailed':
        return WidgetLayout.detailed;
      default:
        return null;
    }
  }

  /// Converts this [WidgetLayout] to a string value.
  String toValue() {
    switch (this) {
      case WidgetLayout.compact:
        return 'compact';
      case WidgetLayout.expanded:
        return 'expanded';
      case WidgetLayout.detailed:
        return 'detailed';
    }
  }
}

