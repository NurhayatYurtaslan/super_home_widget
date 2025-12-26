/// Core abstraction for widget styles.
/// 
/// This abstract class defines the contract that all style implementations
/// must follow. It provides a common interface for style configuration
/// and native style rendering.
library;

import 'style_config.dart';

/// Abstract base class for all widget style implementations.
/// 
/// This interface defines the core contract for widget styling:
/// - Style configuration management
/// - Native style configuration generation
/// - Background, typography, shadow, and padding configuration
abstract class WidgetStyle {
  /// The configuration for this style.
  StyleConfig get config;

  /// The name of this style (e.g., 'liquidGlass').
  String get styleName;

  /// Converts this style to a native configuration map.
  /// 
  /// Returns a [Map] containing all style values needed
  /// by the native iOS widget extension to apply this style.
  Map<String, dynamic> toNativeConfig();

  /// Gets the background configuration for this style.
  Map<String, dynamic> getBackgroundConfig();

  /// Gets the typography configuration for this style.
  Map<String, dynamic> getTypographyConfig();

  /// Gets the shadow configuration for this style.
  Map<String, dynamic> getShadowConfig();

  /// Gets the padding configuration for this style.
  Map<String, dynamic> getPaddingConfig();
}

