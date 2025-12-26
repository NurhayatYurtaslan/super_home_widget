/// Domain model for widget data.
/// 
/// This class represents the data that will be displayed in a widget.
/// It contains all the information needed to render widget content.
library;

/// Domain entity representing widget data.
/// 
/// Contains all the data fields that can be displayed in a widget:
/// - Title and subtitle text
/// - Body content
/// - Image URL and icon name
/// - Custom data map
/// - Timestamp for time-based content
class WidgetData {
  /// The main title text.
  final String? title;

  /// The subtitle text.
  final String? subtitle;

  /// The body content text.
  final String? body;

  /// URL for an image to display.
  final String? imageUrl;

  /// Name of a system icon to display.
  final String? iconName;

  /// Custom data map for additional information.
  final Map<String, dynamic>? customData;

  /// Timestamp for time-based content.
  final DateTime? timestamp;

  /// Creates a new [WidgetData] instance.
  const WidgetData({
    this.title,
    this.subtitle,
    this.body,
    this.imageUrl,
    this.iconName,
    this.customData,
    this.timestamp,
  });

  /// Creates a [WidgetData] from a JSON map.
  factory WidgetData.fromJson(Map<String, dynamic> json) {
    return WidgetData(
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      body: json['body'] as String?,
      imageUrl: json['imageUrl'] as String?,
      iconName: json['iconName'] as String?,
      customData: json['customData'] as Map<String, dynamic>?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
    );
  }

  /// Converts this [WidgetData] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (body != null) 'body': body,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (iconName != null) 'iconName': iconName,
      if (customData != null) 'customData': customData,
      if (timestamp != null) 'timestamp': timestamp!.toIso8601String(),
    };
  }

  /// Creates a copy of this [WidgetData] with updated fields.
  WidgetData copyWith({
    String? title,
    String? subtitle,
    String? body,
    String? imageUrl,
    String? iconName,
    Map<String, dynamic>? customData,
    DateTime? timestamp,
  }) {
    return WidgetData(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      iconName: iconName ?? this.iconName,
      customData: customData ?? this.customData,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

