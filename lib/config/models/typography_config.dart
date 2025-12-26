/// Configuration model for widget typography.
library;

/// Configuration for widget typography styling.
class TypographyConfig {
  /// Font family name.
  final String fontFamily;

  /// Title font size in points.
  final double titleSize;

  /// Body font size in points.
  final double bodySize;

  /// Caption font size in points.
  final double captionSize;

  /// Creates a new [TypographyConfig] instance.
  const TypographyConfig({
    required this.fontFamily,
    required this.titleSize,
    required this.bodySize,
    required this.captionSize,
  });

  /// Creates a [TypographyConfig] from a JSON map.
  factory TypographyConfig.fromJson(Map<String, dynamic> json) {
    return TypographyConfig(
      fontFamily: json['fontFamily'] as String? ?? 'SF Pro Rounded',
      titleSize: (json['titleSize'] as num?)?.toDouble() ?? 22.0,
      bodySize: (json['bodySize'] as num?)?.toDouble() ?? 15.0,
      captionSize: (json['captionSize'] as num?)?.toDouble() ?? 13.0,
    );
  }

  /// Converts this [TypographyConfig] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'fontFamily': fontFamily,
      'titleSize': titleSize,
      'bodySize': bodySize,
      'captionSize': captionSize,
    };
  }
}

