/// Configuration model for widget colors.
library;

/// Configuration for widget color scheme.
class ColorsConfig {
  /// Primary color in hex format.
  final String primary;

  /// Secondary color in hex format.
  final String secondary;

  /// Text color in hex format.
  final String text;

  /// Secondary text color in hex format.
  final String textSecondary;

  /// Creates a new [ColorsConfig] instance.
  const ColorsConfig({
    required this.primary,
    required this.secondary,
    required this.text,
    required this.textSecondary,
  });

  /// Creates a [ColorsConfig] from a JSON map.
  factory ColorsConfig.fromJson(Map<String, dynamic> json) {
    return ColorsConfig(
      primary: json['primary'] as String? ?? '#007AFF',
      secondary: json['secondary'] as String? ?? '#5856D6',
      text: json['text'] as String? ?? '#1C1C1E',
      textSecondary: json['textSecondary'] as String? ?? '#3A3A3C',
    );
  }

  /// Converts this [ColorsConfig] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'primary': primary,
      'secondary': secondary,
      'text': text,
      'textSecondary': textSecondary,
    };
  }
}

