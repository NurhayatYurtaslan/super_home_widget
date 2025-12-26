/// Widget builder factory for creating widget instances.
library;

import '../../core/base_widget_render.dart';
import '../../domain/models/widget_size.dart';
import '../../config/models/super_home_widget_config.dart';
import '../../styles/base/style_manager.dart';
import '../implementations/small_widget.dart';
import '../implementations/medium_widget.dart';
import '../implementations/large_widget.dart';

/// Factory class for creating widget instances.
/// 
/// Uses the configuration to build widgets with appropriate styles
/// and layouts based on widget size.
class WidgetBuilder {
  /// The main configuration.
  final SuperHomeWidgetConfig config;

  /// The style manager for creating styles.
  final StyleManager styleManager;

  /// Creates a new [WidgetBuilder] instance.
  WidgetBuilder({
    required this.config,
    required this.styleManager,
  });

  /// Builds a small widget instance.
  /// 
  /// Returns a [BaseWidgetRender] implementation for small widgets.
  BaseWidgetRender buildSmallWidget() {
    final widgetConfig = config.widgets.small;
    final style = styleManager.getStyleByName(widgetConfig.style);
    if (style == null) {
      throw Exception('Style "${widgetConfig.style}" not found');
    }

    return SmallWidget(
      config: widgetConfig,
      style: style,
      data: config.getInitialData(),
    );
  }

  /// Builds a medium widget instance.
  /// 
  /// Returns a [BaseWidgetRender] implementation for medium widgets.
  BaseWidgetRender buildMediumWidget() {
    final widgetConfig = config.widgets.medium;
    final style = styleManager.getStyleByName(widgetConfig.style);
    if (style == null) {
      throw Exception('Style "${widgetConfig.style}" not found');
    }

    return MediumWidget(
      config: widgetConfig,
      style: style,
      data: config.getInitialData(),
    );
  }

  /// Builds a large widget instance.
  /// 
  /// Returns a [BaseWidgetRender] implementation for large widgets.
  BaseWidgetRender buildLargeWidget() {
    final widgetConfig = config.widgets.large;
    final style = styleManager.getStyleByName(widgetConfig.style);
    if (style == null) {
      throw Exception('Style "${widgetConfig.style}" not found');
    }

    return LargeWidget(
      config: widgetConfig,
      style: style,
      data: config.getInitialData(),
    );
  }

  /// Builds a widget instance for the given size.
  /// 
  /// Returns a [BaseWidgetRender] implementation for the specified widget size.
  BaseWidgetRender buildWidget(WidgetSize size) {
    switch (size) {
      case WidgetSize.small:
        return buildSmallWidget();
      case WidgetSize.medium:
        return buildMediumWidget();
      case WidgetSize.large:
        return buildLargeWidget();
    }
  }
}

