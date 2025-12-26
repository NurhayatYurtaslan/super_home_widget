/// Configuration model for widget borders.
library;

/// Configuration for widget border styling.
class BorderConfig {
  /// Whether the border is enabled.
  final bool enabled;

  /// Border width in points.
  final double width;

  /// Border color in hex format.
  final String color;

  /// Border opacity (0.0 to 1.0).
  final double opacity;

  /// Creates a new [BorderConfig] instance.
  const BorderConfig({
    required this.enabled,
    required this.width,
    required this.color,
    required this.opacity,
  });

  /// Creates a [BorderConfig] from a JSON map.
  factory BorderConfig.fromJson(Map<String, dynamic> json) {
    return BorderConfig(
      enabled: json['enabled'] as bool? ?? true,
      width: (json['width'] as num?)?.toDouble() ?? 1.0,
      color: json['color'] as String? ?? '#FFFFFF',
      opacity: (json['opacity'] as num?)?.toDouble() ?? 0.2,
    );
  }

  /// Converts this [BorderConfig] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'width': width,
      'color': color,
      'opacity': opacity,
    };
  }
}

