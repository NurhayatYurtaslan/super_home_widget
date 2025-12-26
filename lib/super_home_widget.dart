/// Super Home Widget - iOS Home Screen Widget Package for Flutter
///
/// A customizable iOS home screen widget package using Apple's WidgetKit framework.
/// Supports liquid glass (glassmorphic) design style with optional solid background fallback.
library;

// Core abstractions
export 'core/base_widget_render.dart';
export 'core/widget_style.dart';
export 'core/style_config.dart';

// Domain models
export 'domain/models/widget_data.dart';
export 'domain/models/widget_size.dart';
export 'domain/models/widget_layout.dart';
export 'domain/models/widget_dimensions.dart';
export 'domain/config/widget_config.dart';
export 'domain/config/widgets_config.dart';

// Configuration models
export 'config/models/background_config.dart';
export 'config/models/padding_config.dart';
export 'config/models/typography_config.dart';
export 'config/models/colors_config.dart';
export 'config/models/shadow_config.dart';
export 'config/models/border_config.dart';
export 'config/models/gradient_config.dart';
export 'config/models/highlights_config.dart';
export 'config/models/widget_style_type.dart';
export 'config/models/style_config_models.dart';
export 'config/models/super_home_widget_config.dart';
export 'config/parsers/config_parser.dart';

// Widget implementations
export 'widgets/base/widget_builder.dart';
export 'widgets/implementations/small_widget.dart';
export 'widgets/implementations/medium_widget.dart';
export 'widgets/implementations/large_widget.dart';

// Style implementations
export 'styles/base/style_manager.dart';
export 'styles/implementations/liquid_glass_style.dart';
export 'styles/builders/style_builder.dart';

// Infrastructure
export 'infrastructure/native/ios_bridge.dart';

// Import aliases for internal use
import 'config/parsers/config_parser.dart' as config_parser;
import 'config/models/super_home_widget_config.dart'
    as super_home_widget_config;
import 'widgets/base/widget_builder.dart' as widget_builder;
import 'styles/base/style_manager.dart' as style_manager;
import 'infrastructure/native/ios_bridge.dart';
import 'domain/models/widget_data.dart';
import 'domain/models/widget_size.dart';

/// Main Super Home Widget class.
///
/// Provides a singleton interface for initializing and managing widgets.
class SuperHomeWidget {
  /// Singleton instance.
  static SuperHomeWidget? _instance;

  /// iOS bridge instance.
  final IOSBridge _iosBridge = IOSBridge();

  /// Current configuration.
  super_home_widget_config.SuperHomeWidgetConfig? _config;

  /// Widget builder instance.
  widget_builder.WidgetBuilder? _widgetBuilder;

  /// Style manager instance.
  style_manager.StyleManager? _styleManager;

  /// Private constructor for singleton pattern.
  SuperHomeWidget._();

  /// Gets the singleton instance.
  factory SuperHomeWidget() {
    _instance ??= SuperHomeWidget._();
    return _instance!;
  }

  /// Initializes the widget system.
  ///
  /// [appGroupId] is the App Group identifier for shared container.
  /// [configPath] is the optional path to custom configuration file in assets.
  /// If not provided, uses default package configuration.
  Future<void> initialize({
    required String appGroupId,
    String? configPath,
  }) async {
    // Initialize iOS bridge
    await _iosBridge.initialize(appGroupId: appGroupId);

    // Load configuration
    _config = await config_parser.ConfigParser.loadConfig(
      configPath: configPath,
    );

    // Save config to App Group so widget can access it
    await _iosBridge.saveConfig(_config!.toJson());

    // Initialize style manager
    _styleManager = style_manager.StyleManager(config: _config!);

    // Initialize widget builder
    _widgetBuilder = widget_builder.WidgetBuilder(
      config: _config!,
      styleManager: _styleManager!,
    );

    // Send initial data to widget
    final initialData = _config!.getInitialData();
    if (initialData != null) {
      await _iosBridge.updateWidgetData(
        data: initialData,
        widgetSize: WidgetSize.large
            .toValue(), // Default to large for initial display
      );
    }
  }

  /// Gets the current configuration.
  super_home_widget_config.SuperHomeWidgetConfig? get config => _config;

  /// Gets the widget builder.
  widget_builder.WidgetBuilder? get widgetBuilder => _widgetBuilder;

  /// Gets the style manager.
  style_manager.StyleManager? get styleManager => _styleManager;

  /// Gets the iOS bridge.
  IOSBridge get iosBridge => _iosBridge;

  /// Updates widget data.
  ///
  /// [data] is the widget data to update.
  /// [widgetSize] is the size of the widget.
  Future<void> updateWidgetData({
    required WidgetData data,
    required WidgetSize widgetSize,
  }) async {
    await _iosBridge.updateWidgetData(
      data: data,
      widgetSize: widgetSize.toValue(),
    );
  }

  /// Refreshes all widgets.
  Future<void> refreshAllWidgets() async {
    await _iosBridge.refreshAllWidgets();
  }

  /// Refreshes a specific widget.
  ///
  /// [widgetSize] is the size of the widget to refresh.
  Future<void> refreshWidget({required WidgetSize widgetSize}) async {
    await _iosBridge.refreshWidget(widgetSize: widgetSize.toValue());
  }

  /// Gets the stream of widget click events.
  Stream<Map<String, dynamic>> getClickEvents() {
    return _iosBridge.getClickEvents();
  }
}
