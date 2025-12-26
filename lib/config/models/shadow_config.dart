/// Configuration model for widget shadows.
library;

/// Configuration for a single shadow layer.
class ShadowLayer {
  /// Shadow opacity (0.0 to 1.0).
  final double opacity;

  /// Shadow blur radius in points.
  final double radius;

  /// Shadow offset in points.
  final Map<String, double> offset;

  /// Creates a new [ShadowLayer] instance.
  const ShadowLayer({
    required this.opacity,
    required this.radius,
    required this.offset,
  });

  /// Creates a [ShadowLayer] from a JSON map.
  factory ShadowLayer.fromJson(Map<String, dynamic> json) {
    final offsetJson = json['offset'] as Map<String, dynamic>? ?? {};
    return ShadowLayer(
      opacity: (json['opacity'] as num?)?.toDouble() ?? 0.2,
      radius: (json['radius'] as num?)?.toDouble() ?? 8.0,
      offset: {
        'x': (offsetJson['x'] as num?)?.toDouble() ?? 0.0,
        'y': (offsetJson['y'] as num?)?.toDouble() ?? 4.0,
      },
    );
  }

  /// Converts this [ShadowLayer] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'opacity': opacity,
      'radius': radius,
      'offset': offset,
    };
  }
}

/// Configuration for widget shadow effects.
class ShadowConfig {
  /// Whether shadows are enabled.
  final bool enabled;

  /// List of shadow layers.
  final List<ShadowLayer> layers;

  /// Creates a new [ShadowConfig] instance.
  const ShadowConfig({
    required this.enabled,
    required this.layers,
  });

  /// Creates a [ShadowConfig] from a JSON map.
  factory ShadowConfig.fromJson(Map<String, dynamic> json) {
    final layersJson = json['layers'] as List<dynamic>? ?? [];
    return ShadowConfig(
      enabled: json['enabled'] as bool? ?? true,
      layers: layersJson
          .map((layer) => ShadowLayer.fromJson(layer as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Converts this [ShadowConfig] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'layers': layers.map((layer) => layer.toJson()).toList(),
    };
  }
}

