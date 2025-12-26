/// Style manager factory for creating style instances.
library;

import '../../core/widget_style.dart';
import '../../config/models/widget_style_type.dart';
import '../../config/models/super_home_widget_config.dart';
import '../../config/models/style_config_models.dart';
import '../implementations/liquid_glass_style.dart';

/// Factory class for creating style instances.
/// 
/// Manages style creation and retrieval based on configuration.
class StyleManager {
  /// The main configuration.
  final SuperHomeWidgetConfig config;

  /// Creates a new [StyleManager] instance.
  StyleManager({required this.config});

  /// Gets a style by type.
  /// 
  /// Returns a [WidgetStyle] instance for the given [type].
  /// Returns `null` if the style type is not supported or not found.
  WidgetStyle? getStyle(WidgetStyleType type) {
    switch (type) {
      case WidgetStyleType.liquidGlass:
        final styleConfig = config.getStyle('liquidGlass');
        if (styleConfig == null) return null;
        if (styleConfig is LiquidGlassStyleConfig) {
          return LiquidGlassStyle(config: styleConfig);
        }
        return null;
    }
  }

  /// Gets a style by name.
  /// 
  /// Returns a [WidgetStyle] instance for the given [name].
  /// Returns `null` if the style name is not found.
  WidgetStyle? getStyleByName(String name) {
    final styleType = WidgetStyleType.fromString(name);
    if (styleType == null) return null;
    return getStyle(styleType);
  }
}

/// Builder pattern for creating custom styles.
/// 
/// Provides a fluent API for building style configurations.
class StyleBuilder {
  /// The style configuration being built.
  Map<String, dynamic> _config = {};

  /// Sets the background configuration.
  StyleBuilder background(Map<String, dynamic> background) {
    _config['background'] = background;
    return this;
  }

  /// Sets the corner radius.
  StyleBuilder cornerRadius(double radius) {
    _config['cornerRadius'] = radius;
    return this;
  }

  /// Sets the padding configuration.
  StyleBuilder padding(Map<String, dynamic> padding) {
    _config['padding'] = padding;
    return this;
  }

  /// Sets the typography configuration.
  StyleBuilder typography(Map<String, dynamic> typography) {
    _config['typography'] = typography;
    return this;
  }

  /// Sets the colors configuration.
  StyleBuilder colors(Map<String, dynamic> colors) {
    _config['colors'] = colors;
    return this;
  }

  /// Sets the shadows configuration.
  StyleBuilder shadows(Map<String, dynamic> shadows) {
    _config['shadows'] = shadows;
    return this;
  }

  /// Builds a liquid glass style configuration.
  /// 
  /// Returns a [LiquidGlassStyleConfig] instance.
  LiquidGlassStyleConfig buildLiquidGlass() {
    return LiquidGlassStyleConfig.fromJson(_config);
  }

  /// Resets the builder to start a new configuration.
  StyleBuilder reset() {
    _config = {};
    return this;
  }
}

