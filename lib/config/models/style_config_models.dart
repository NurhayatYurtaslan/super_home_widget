/// Configuration models for widget styles.
/// 
/// Contains the abstract StyleConfig base class and concrete implementations
/// like LiquidGlassStyleConfig.
library;

import '../../core/style_config.dart';
import 'background_config.dart';
import 'padding_config.dart';
import 'typography_config.dart';
import 'colors_config.dart';
import 'shadow_config.dart';
import 'border_config.dart';
import 'gradient_config.dart';
import 'highlights_config.dart';

/// Abstract base class for all style configuration implementations.
/// 
/// This class defines the common properties shared by all style configurations.
/// Concrete implementations should extend this class and add style-specific properties.
abstract class StyleConfigBase implements StyleConfig {
  /// Background configuration.
  BackgroundConfig get backgroundConfig;

  /// Corner radius for rounded corners.
  double get cornerRadiusValue;

  /// Padding configuration.
  PaddingConfig get paddingConfig;

  /// Typography configuration.
  TypographyConfig get typographyConfig;

  /// Colors configuration.
  ColorsConfig get colorsConfig;

  /// Shadow configuration.
  ShadowConfig get shadowConfig;

  /// Gets the background configuration as a map.
  @override
  Map<String, dynamic> get background => backgroundConfig.toJson();

  /// Gets the corner radius.
  @override
  double get cornerRadius => cornerRadiusValue;

  /// Gets the padding configuration as a map.
  @override
  Map<String, dynamic> get padding => paddingConfig.toJson();

  /// Gets the typography configuration as a map.
  @override
  Map<String, dynamic> get typography => typographyConfig.toJson();

  /// Gets the colors configuration as a map.
  @override
  Map<String, dynamic> get colors => colorsConfig.toJson();

  /// Gets the shadow configuration as a map.
  @override
  Map<String, dynamic> get shadows => shadowConfig.toJson();

  /// Converts this style config to a JSON map.
  Map<String, dynamic> toJson();
}

/// Configuration for liquid glass style.
/// 
/// Extends [StyleConfigBase] with liquid glass specific properties.
/// When [liquidGlassEnabled] is `true`, applies frosted glass effect.
/// When `false`, uses solid background color from [background.color].
class LiquidGlassStyleConfig extends StyleConfigBase {
  /// Whether liquid glass effect is enabled.
  /// 
  /// When `true`: Frosted glass effect with blur (default).
  /// When `false`: Solid background color from [background.color].
  final bool liquidGlassEnabled;

  /// Background configuration.
  @override
  final BackgroundConfig backgroundConfig;

  /// Corner radius for rounded corners.
  @override
  final double cornerRadiusValue;

  /// Padding configuration.
  @override
  final PaddingConfig paddingConfig;

  /// Typography configuration.
  @override
  final TypographyConfig typographyConfig;

  /// Colors configuration.
  @override
  final ColorsConfig colorsConfig;

  /// Shadow configuration.
  @override
  final ShadowConfig shadowConfig;

  /// Border configuration (used when liquid glass is enabled).
  final BorderConfig border;

  /// Gradient configuration (used when liquid glass is enabled).
  final GradientConfig gradient;

  /// Highlights configuration (used when liquid glass is enabled).
  final HighlightsConfig highlights;

  /// Creates a new [LiquidGlassStyleConfig] instance.
  LiquidGlassStyleConfig({
    this.liquidGlassEnabled = true,
    required this.backgroundConfig,
    required this.cornerRadiusValue,
    required this.paddingConfig,
    required this.typographyConfig,
    required this.colorsConfig,
    required this.shadowConfig,
    required this.border,
    required this.gradient,
    required this.highlights,
  });

  /// Creates a [LiquidGlassStyleConfig] from a JSON map.
  factory LiquidGlassStyleConfig.fromJson(Map<String, dynamic> json) {
    return LiquidGlassStyleConfig(
      liquidGlassEnabled: json['liquidGlassEnabled'] as bool? ?? true,
      backgroundConfig: BackgroundConfig.fromJson(
        json['background'] as Map<String, dynamic>? ?? {},
      ),
      cornerRadiusValue: (json['cornerRadius'] as num?)?.toDouble() ?? 20.0,
      paddingConfig: PaddingConfig.fromJson(
        json['padding'] as Map<String, dynamic>? ?? {},
      ),
      typographyConfig: TypographyConfig.fromJson(
        json['typography'] as Map<String, dynamic>? ?? {},
      ),
      colorsConfig: ColorsConfig.fromJson(
        json['colors'] as Map<String, dynamic>? ?? {},
      ),
      shadowConfig: ShadowConfig.fromJson(
        json['shadows'] as Map<String, dynamic>? ?? {},
      ),
      border: BorderConfig.fromJson(
        json['border'] as Map<String, dynamic>? ?? {},
      ),
      gradient: GradientConfig.fromJson(
        json['gradient'] as Map<String, dynamic>? ?? {},
      ),
      highlights: HighlightsConfig.fromJson(
        json['highlights'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  /// Converts this [LiquidGlassStyleConfig] to a JSON map.
  @override
  Map<String, dynamic> toJson() {
    return {
      'liquidGlassEnabled': liquidGlassEnabled,
      'background': backgroundConfig.toJson(),
      'cornerRadius': cornerRadiusValue,
      'padding': paddingConfig.toJson(),
      'typography': typographyConfig.toJson(),
      'colors': colorsConfig.toJson(),
      'shadows': shadowConfig.toJson(),
      'border': border.toJson(),
      'gradient': gradient.toJson(),
      'highlights': highlights.toJson(),
    };
  }
}

