/// Configuration parser for loading and parsing widget configuration files.
library;

import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/super_home_widget_config.dart';

/// Parser for widget configuration files.
/// 
/// Handles loading and parsing JSON configuration files from assets
/// or package resources.
class ConfigParser {
  /// Default configuration path in the package.
  static const String defaultConfigPath = 'packages/super_home_widget/config/widget_config.json';

  /// Loads and parses a configuration file.
  /// 
  /// [configPath] is the path to the configuration file in assets.
  /// If not provided or file doesn't exist, falls back to default package config.
  /// 
  /// Returns a [SuperHomeWidgetConfig] instance.
  /// Throws an exception if configuration cannot be loaded or parsed.
  static Future<SuperHomeWidgetConfig> loadConfig({
    String? configPath,
  }) async {
    String jsonString;

    // Try to load custom config first
    if (configPath != null) {
      try {
        jsonString = await rootBundle.loadString(configPath);
      } catch (e) {
        // Fall back to default config if custom config not found
        try {
          jsonString = await rootBundle.loadString(defaultConfigPath);
        } catch (e2) {
          throw Exception(
            'Failed to load configuration: Custom config not found at "$configPath" '
            'and default config not found at "$defaultConfigPath". Error: $e2',
          );
        }
      }
    } else {
      // Load default config
      try {
        jsonString = await rootBundle.loadString(defaultConfigPath);
      } catch (e) {
        throw Exception(
          'Failed to load default configuration at "$defaultConfigPath". Error: $e',
        );
      }
    }

    // Parse JSON
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return SuperHomeWidgetConfig.fromJson(json);
    } catch (e) {
      throw Exception('Failed to parse configuration JSON. Error: $e');
    }
  }

  /// Parses a configuration from a JSON string.
  /// 
  /// [jsonString] is the JSON configuration string.
  /// Returns a [SuperHomeWidgetConfig] instance.
  /// Throws an exception if JSON cannot be parsed.
  static SuperHomeWidgetConfig parseConfig(String jsonString) {
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return SuperHomeWidgetConfig.fromJson(json);
    } catch (e) {
      throw Exception('Failed to parse configuration JSON. Error: $e');
    }
  }
}

