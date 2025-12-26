/// Core abstraction for style configurations.
/// 
/// This abstract class defines the base structure for all style configurations.
/// It provides common properties that all style configurations must have.
library;

/// Abstract base class for all style configuration implementations.
/// 
/// This class defines the common properties shared by all style configurations:
/// - Background configuration
/// - Corner radius
/// - Padding configuration
/// - Typography configuration
/// - Colors configuration
/// - Shadow configuration
abstract class StyleConfig {
  /// Background configuration.
  Map<String, dynamic> get background;

  /// Corner radius for rounded corners.
  double get cornerRadius;

  /// Padding configuration.
  Map<String, dynamic> get padding;

  /// Typography configuration.
  Map<String, dynamic> get typography;

  /// Colors configuration.
  Map<String, dynamic> get colors;

  /// Shadow configuration.
  Map<String, dynamic> get shadows;
}

