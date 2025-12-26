/// Configuration model for widget backgrounds.
library;

/// Configuration for widget background styling.
class BackgroundConfig {
  /// Background type: 'solid', 'frosted', or 'gradient'.
  final String type;

  /// Background style (for frosted type): 'systemMaterial', 'ultraThinMaterial', etc.
  final String? style;

  /// Background color in hex format (e.g., '#FFFFFF').
  final String color;

  /// Background opacity (0.0 to 1.0).
  final double opacity;

  /// Blur radius for frosted backgrounds.
  final double? blurRadius;

  /// Creates a new [BackgroundConfig] instance.
  const BackgroundConfig({
    required this.type,
    this.style,
    required this.color,
    required this.opacity,
    this.blurRadius,
  });

  /// Creates a [BackgroundConfig] from a JSON map.
  factory BackgroundConfig.fromJson(Map<String, dynamic> json) {
    return BackgroundConfig(
      type: json['type'] as String? ?? 'solid',
      style: json['style'] as String?,
      color: json['color'] as String? ?? '#FFFFFF',
      opacity: (json['opacity'] as num?)?.toDouble() ?? 1.0,
      blurRadius: (json['blurRadius'] as num?)?.toDouble(),
    );
  }

  /// Converts this [BackgroundConfig] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      if (style != null) 'style': style,
      'color': color,
      'opacity': opacity,
      if (blurRadius != null) 'blurRadius': blurRadius,
    };
  }
}

