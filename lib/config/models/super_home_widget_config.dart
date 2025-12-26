/// Main configuration model for Super Home Widget.
/// 
/// This is the root configuration container that holds all widget
/// and style configurations.
library;

import '../../domain/config/widgets_config.dart';
import '../../domain/models/widget_data.dart';
import 'style_config_models.dart';

/// Main configuration container for Super Home Widget.
/// 
/// Contains all configuration values needed to initialize and configure
/// the widget system, including styles, widgets, and initial data.
class SuperHomeWidgetConfig {
  /// Widget metadata (id, name, version).
  final Map<String, String> widget;

  /// Style configurations map (key: style name, value: style config).
  final Map<String, StyleConfigBase> styles;

  /// Widgets configuration (small, medium, large).
  final WidgetsConfig widgets;

  /// Data configuration (sources, update strategy, initial data).
  final Map<String, dynamic> data;

  /// Creates a new [SuperHomeWidgetConfig] instance.
  const SuperHomeWidgetConfig({
    required this.widget,
    required this.styles,
    required this.widgets,
    required this.data,
  });

  /// Creates a [SuperHomeWidgetConfig] from a JSON map.
  factory SuperHomeWidgetConfig.fromJson(Map<String, dynamic> json) {
    // Parse styles
    final stylesJson = json['styles'] as Map<String, dynamic>? ?? {};
    final styles = <String, StyleConfigBase>{};

    for (final entry in stylesJson.entries) {
      final styleName = entry.key;
      final styleJson = entry.value as Map<String, dynamic>;

      if (styleName == 'liquidGlass') {
        styles[styleName] = LiquidGlassStyleConfig.fromJson(styleJson);
      }
    }

    // Parse widgets
    final widgetsJson = json['widgets'] as Map<String, dynamic>? ?? {};
    final widgets = WidgetsConfig.fromJson(widgetsJson);

    // Parse data
    final dataJson = json['data'] as Map<String, dynamic>? ?? {};

    return SuperHomeWidgetConfig(
      widget: Map<String, String>.from(
        json['widget'] as Map<String, dynamic>? ?? {},
      ),
      styles: styles,
      widgets: widgets,
      data: dataJson,
    );
  }

  /// Converts this [SuperHomeWidgetConfig] to a JSON map.
  Map<String, dynamic> toJson() {
    final stylesJson = <String, dynamic>{};
    for (final entry in styles.entries) {
      stylesJson[entry.key] = entry.value.toJson();
    }

    return {
      'widget': widget,
      'styles': stylesJson,
      'widgets': widgets.toJson(),
      'data': data,
    };
  }

  /// Gets a style configuration by name.
  /// 
  /// Returns `null` if the style doesn't exist.
  StyleConfigBase? getStyle(String name) {
    return styles[name];
  }

  /// Gets the initial widget data from configuration.
  WidgetData? getInitialData() {
    final initialDataJson = data['initialData'] as Map<String, dynamic>?;
    if (initialDataJson == null) return null;
    return WidgetData.fromJson(initialDataJson);
  }
}

