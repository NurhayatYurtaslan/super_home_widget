/// Large widget implementation.
/// 
/// Implements BaseWidgetRender for large (4x4 grid cells) widgets.
library;

import '../../core/base_widget_render.dart';
import '../../core/widget_style.dart';
import '../../domain/models/widget_data.dart';
import '../../domain/models/widget_size.dart';
import '../../domain/models/widget_layout.dart';
import '../../domain/models/widget_dimensions.dart';
import '../../domain/config/widget_config.dart';

/// Large widget implementation (329x345pt on iPhone, 364x376pt on iPad).
/// 
/// Uses detailed layout for rich content display.
class LargeWidget implements BaseWidgetRender {
  /// Widget configuration.
  final WidgetConfig config;

  /// Style applied to this widget.
  @override
  final WidgetStyle style;

  /// Data to display in the widget.
  @override
  final WidgetData? data;

  /// Creates a new [LargeWidget] instance.
  const LargeWidget({
    required this.config,
    required this.style,
    this.data,
  });

  /// Widget size (always large).
  @override
  WidgetSize get size => WidgetSize.large;

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

