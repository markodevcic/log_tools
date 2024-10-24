import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:log_tools/utils/constants.dart';

/// Helper functions for logging.
///
/// This file contains various utility functions that assist in formatting
/// log messages and data, including color application and JSON formatting.
String applyColor(String text, String colorCode) {
  /// Applies a color to the given text using ANSI escape codes.
  return '$colorCode$text$reset';
}

String curlRepresentation(RequestOptions options) {
  /// Generates a CURL command representation for the given request options.
  List<String> components = ["${grey}curl -i "];

  // Building the CURL command components.
  components.add("-X ${options.method.toUpperCase()} ");

  options.headers.forEach((k, v) {
    if (k != "Cookie") {
      components.add("-H \"$k: $v\" ");
    }
  });

  var data = json.encode(options.data);
  data = data.replaceAll('"', '\\"');
  components.add("-d \"$data\" ");

  components.add("\"${options.uri.toString()}\" ");

  return components.join('\\\n\t');
}

String formatJson(
    Object json, String keyColor, String valueColor, String braceColor) {
  /// Formats a JSON object into a readable string with color coding.
  var buffer = StringBuffer();
  buffer.write('$braceColor{\n');

  // Helper function to recursively format JSON
  void formatEntry(String key, dynamic value, int indentLevel) {
    String indent = '  ' * indentLevel; // Create indentation based on level
    if (value is Map) {
      if (value.isNotEmpty) {
        buffer.write('$indent$keyColor"$key"$reset: $braceColor{\n');
        value.forEach((k, v) {
          formatEntry(k, v, indentLevel + 1); // Recurse into map
        });
        buffer.write('$indent$braceColor},\n');
      } else {
        buffer.write(
            '$indent$keyColor"$key"$reset: $braceColor{},\n'); // For empty maps
      }
    } else if (value is List) {
      if (value.isNotEmpty) {
        buffer.write('$indent$keyColor"$key"$reset: $braceColor[\n');
        for (var item in value) {
          if (item is Map) {
            buffer.write('$indent  $braceColor{\n');
            item.forEach((k, v) {
              formatEntry(k, v, indentLevel + 2); // Recurse into map
            });
            buffer.write('$indent  $braceColor},\n');
          } else {
            buffer.write(
                '$indent  $valueColor"$item"$reset,\n'); // Directly log other types
          }
        }
        buffer.write('$indent$braceColor],\n');
      } else {
        buffer.write(
            '$indent$keyColor"$key"$reset: $braceColor[],\n'); // For empty lists
      }
    } else {
      buffer
          .write('$indent$keyColor"$key"$reset: $valueColor"$value"$reset,\n');
    }
  }

  // Implementation for processing Map and List types.
  if (json is Map) {
    json.forEach((key, value) {
      formatEntry(key, value, 1);
    });
  } else if (json is List) {
    for (var item in json) {
      if (item is Map) {
        item.forEach((key, value) {
          formatEntry(key, value, 1);
        });
      }
    }
  }

  // Remove the last comma and newline
  if (buffer.isNotEmpty) {
    buffer.write('\b\b');
  }

  buffer.write('$braceColor}');
  return buffer.toString();
}

String extractEndpoint(String url) {
  /// Extracts the endpoint from a given URL.
  String pattern = r'/(api/v\d+/)?(.+)';
  RegExp regExp = RegExp(pattern);
  String? endpoint;

  var match = regExp.firstMatch(url);
  if (match != null) {
    endpoint = match.group(2);
  }

  return '/$endpoint';
}
