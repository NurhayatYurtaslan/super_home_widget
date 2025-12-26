/// Liquid glass style implementation.
/// 
/// Implements WidgetStyle for glassmorphic (liquid glass) design.
library;

import '../../core/widget_style.dart';
import '../../core/style_config.dart';
import '../../config/models/style_config_models.dart';

/// Liquid glass style implementation.
/// 
/// Provides glassmorphic (frosted glass) appearance with optional solid
/// background fallback when liquid glass is disabled.
class LiquidGlassStyle implements WidgetStyle {
  /// The liquid glass style configuration.
  final LiquidGlassStyleConfig _config;

  /// Creates a new [LiquidGlassStyle] instance.
  const LiquidGlassStyle({required LiquidGlassStyleConfig config})
      : _config = config;

  /// Style name (always 'liquidGlass').
  @override
  String get styleName => 'liquidGlass';

  /// Gets the style configuration.
  @override
  StyleConfig get config => _config;

  /// Converts this style to a native configuration map.
  @override
  Map<String, dynamic> toNativeConfig() {
    return {
      'styleName': styleName,
      'liquidGlassEnabled': _config.liquidGlassEnabled,
      'background': getBackgroundConfig(),
      'cornerRadius': _config.cornerRadius,
      'padding': getPaddingConfig(),
      'typography': getTypographyConfig(),
      'colors': getColorsConfig(),
      'shadows': getShadowConfig(),
      'border': _config.border.toJson(),
      'gradient': _config.gradient.toJson(),
      'highlights': _config.highlights.toJson(),
    };
  }

  /// Gets the background configuration.
  @override
  Map<String, dynamic> getBackgroundConfig() {
    final bgConfig = _config.backgroundConfig.toJson();
    if (!_config.liquidGlassEnabled) {
      // When liquid glass is disabled, use solid background
      bgConfig['type'] = 'solid';
      bgConfig['opacity'] = _config.backgroundConfig.opacity;
    }
    return bgConfig;
  }

  /// Gets the typography configuration.
  @override
  Map<String, dynamic> getTypographyConfig() {
    return _config.typographyConfig.toJson();
  }

  /// Gets the shadow configuration.
  @override
  Map<String, dynamic> getShadowConfig() {
    return _config.shadowConfig.toJson();
  }

  /// Gets the padding configuration.
  @override
  Map<String, dynamic> getPaddingConfig() {
    return _config.paddingConfig.toJson();
  }

  /// Gets the colors configuration.
  Map<String, dynamic> getColorsConfig() {
    return _config.colorsConfig.toJson();
  }
}

