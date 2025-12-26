/// Small widget implementation.
/// 
/// Implements BaseWidgetRender for small (2x2 grid cells) widgets.
library;

import '../../core/base_widget_render.dart';
import '../../core/widget_style.dart';
import '../../domain/models/widget_data.dart';
import '../../domain/models/widget_size.dart';
import '../../domain/models/widget_layout.dart';
import '../../domain/models/widget_dimensions.dart';
import '../../domain/config/widget_config.dart';

/// Small widget implementation (155x155pt on iPhone, 170x170pt on iPad).
/// 
/// Uses compact layout for minimal content display.
class SmallWidget implements BaseWidgetRender {
  /// Widget configuration.
  final WidgetConfig config;

  /// Style applied to this widget.
  @override
  final WidgetStyle style;

  /// Data to display in the widget.
  @override
  final WidgetData? data;

  /// Creates a new [SmallWidget] instance.
  const SmallWidget({
    required this.config,
    required this.style,
    this.data,
  });

  /// Widget size (always small).
  @override
  WidgetSize get size => WidgetSize.small;

  /// Widget layout (from config).
  @override
  WidgetLayout get layout => config.layout;

  /// Builds the native configuration map for this widget.
  @override
  Map<String, dynamic> buildNativeConfig() {
    return {
      'size': size.toValue(),
      'layout': layout.toValue(),
      'style': style.toNativeConfig(),
      'data': data?.toJson(),
    };
  }

  /// Gets the dimensions for this widget.
  @override
  Map<String, double> getDimensions({bool isIPad = false}) {
    final dimensions = isIPad
        ? WidgetDimensions.forIPad(size)
        : WidgetDimensions.forIPhone(size);
    return dimensions.toMap();
  }
}

