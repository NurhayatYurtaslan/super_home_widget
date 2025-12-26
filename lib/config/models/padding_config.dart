/// Configuration model for widget padding.
library;

/// Configuration for widget padding.
class PaddingConfig {
  /// Horizontal padding in points.
  final double horizontal;

  /// Vertical padding in points.
  final double vertical;

  /// Creates a new [PaddingConfig] instance.
  const PaddingConfig({
    required this.horizontal,
    required this.vertical,
  });

  /// Creates a [PaddingConfig] from a JSON map.
  factory PaddingConfig.fromJson(Map<String, dynamic> json) {
    return PaddingConfig(
      horizontal: (json['horizontal'] as num?)?.toDouble() ?? 16.0,
      vertical: (json['vertical'] as num?)?.toDouble() ?? 16.0,
    );
  }

  /// Converts this [PaddingConfig] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'horizontal': horizontal,
      'vertical': vertical,
    };
  }
}

