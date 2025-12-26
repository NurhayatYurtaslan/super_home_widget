/// Configuration model for widget highlights.
library;

/// Configuration for widget highlight effects.
class HighlightsConfig {
  /// Whether highlights are enabled.
  final bool enabled;

  /// Highlight opacity (0.0 to 1.0).
  final double opacity;

  /// Highlight position: 'top-left', 'top-right', 'bottom-left', 'bottom-right'.
  final String position;

  /// Creates a new [HighlightsConfig] instance.
  const HighlightsConfig({
    required this.enabled,
    required this.opacity,
    required this.position,
  });

  /// Creates a [HighlightsConfig] from a JSON map.
  factory HighlightsConfig.fromJson(Map<String, dynamic> json) {
    return HighlightsConfig(
      enabled: json['enabled'] as bool? ?? true,
      opacity: (json['opacity'] as num?)?.toDouble() ?? 0.4,
      position: json['position'] as String? ?? 'top-left',
    );
  }

  /// Converts this [HighlightsConfig] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'opacity': opacity,
      'position': position,
    };
  }
}

