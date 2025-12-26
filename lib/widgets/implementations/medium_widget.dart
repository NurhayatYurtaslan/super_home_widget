/// Medium widget implementation.
/// 
/// Implements BaseWidgetRender for medium (4x2 grid cells) widgets.
library;

import '../../core/base_widget_render.dart';
import '../../core/widget_style.dart';
import '../../domain/models/widget_data.dart';
import '../../domain/models/widget_size.dart';
import '../../domain/models/widget_layout.dart';
import '../../domain/models/widget_dimensions.dart';
import '../../domain/config/widget_config.dart';

/// Medium widget implementation (329x155pt on iPhone, 364x170pt on iPad).
/// 
/// Uses expanded layout for moderate content display.
class MediumWidget implements BaseWidgetRender {
  /// Widget configuration.
  final WidgetConfig config;

  /// Style applied to this widget.
  @override
  final WidgetStyle style;

  /// Data to display in the widget.
  @override
  final WidgetData? data;

  /// Creates a new [MediumWidget] instance.
  const MediumWidget({
    required this.config,
    required this.style,
    this.data,
  });

  /// Widget size (always medium).
  @override
  WidgetSize get size => WidgetSize.medium;

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

