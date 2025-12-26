/// Core abstraction for widget rendering.
/// 
/// This abstract class defines the contract that all widget implementations
/// must follow. It provides a common interface for building native widget
/// configurations and retrieving widget dimensions.
library;

import '../domain/models/widget_data.dart';
import '../domain/models/widget_size.dart';
import '../domain/models/widget_layout.dart';
import 'widget_style.dart';

/// Abstract base class for all widget render implementations.
/// 
/// This interface defines the core contract for widget rendering:
/// - Widget size and layout configuration
/// - Style application
/// - Data management
/// - Native configuration building
/// - Dimension calculations
abstract class BaseWidgetRender {
  /// The size of the widget (small, medium, or large).
  WidgetSize get size;

  /// The layout style for the widget (compact, expanded, or detailed).
  WidgetLayout get layout;

  /// The style applied to this widget.
  WidgetStyle get style;

  /// The data to be displayed in the widget.
  WidgetData? get data;

  /// Builds the native configuration map for this widget.
  /// 
  /// Returns a [Map] containing all configuration values needed
  /// by the native iOS widget extension to render this widget.
  Map<String, dynamic> buildNativeConfig();

  /// Gets the dimensions for this widget.
  /// 
  /// [isIPad] indicates whether the widget is running on an iPad.
  /// Returns a [Map] with 'width' and 'height' keys.
  Map<String, double> getDimensions({bool isIPad = false});
}

