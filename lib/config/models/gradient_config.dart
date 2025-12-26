/// Configuration model for widget gradients.
library;

/// Configuration for widget gradient effects.
class GradientConfig {
  /// Whether the gradient is enabled.
  final bool enabled;

  /// List of gradient colors in hex format.
  final List<String> colors;

  /// Gradient angle in degrees.
  final double angle;

  /// Creates a new [GradientConfig] instance.
  const GradientConfig({
    required this.enabled,
    required this.colors,
    required this.angle,
  });

  /// Creates a [GradientConfig] from a JSON map.
  factory GradientConfig.fromJson(Map<String, dynamic> json) {
    final colorsJson = json['colors'] as List<dynamic>? ?? [];
    return GradientConfig(
      enabled: json['enabled'] as bool? ?? false,
      colors: colorsJson.map((c) => c as String).toList(),
      angle: (json['angle'] as num?)?.toDouble() ?? 135.0,
    );
  }

  /// Converts this [GradientConfig] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'colors': colors,
      'angle': angle,
    };
  }
}

