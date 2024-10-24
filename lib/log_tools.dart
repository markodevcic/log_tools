library log_tools;

export 'package:log_tools/info/info_utils.dart';
export 'package:log_tools/log_tools_dio_interceptor/log_tools_dio_interceptor.dart';

/// A logging library for handling HTTP requests and responses using Dio.
///
/// This file provides the main logging functionality, including methods to log
/// requests, responses, and errors in a formatted manner. It also exports utility
/// classes for structured logging.
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:log_tools/info/info_utils.dart';
import 'package:log_tools/utils/constants.dart';
import 'package:log_tools/utils/helpers.dart';

class LogTools {
  /// Logs errors encountered during HTTP requests.
  ///
  /// [dioException]: The DioException object containing error details.
  /// [show]: Whether to display the error log.
  /// [showData]: Whether to include the response data in the log.
  static void dioInterceptorError(
      {required DioException dioException,
      required bool show,
      required bool showData}) {
    if (show) {
      String? formattedData;

      try {
        if (dioException.response?.data != null) {
          formattedData =
              formatJson(dioException.response?.data, grey, red, white);
        }
      } catch (e) {
        formattedData = 'Unable to format headers: $e';
      }

      String endpoint = extractEndpoint(dioException.requestOptions.uri.path);

      log("""
${'-' * 20} ${applyColor('Error', white)} ${applyColor(endpoint, red)} ${'-' * 20}\n
${applyColor('URL:', white)} ${applyColor(dioException.requestOptions.uri.toString(), red)}\n
${applyColor('Method:', white)} ${applyColor(dioException.requestOptions.method, red)} 
${applyColor('StatusCode:', white)} ${applyColor(dioException.response!.statusCode.toString(), red)}
${applyColor('Headers:', white)} ${applyColor(json.encode(dioException.response?.headers.map), red)}
${formattedData != null && showData ? '${applyColor('Data:', white)} $formattedData\n' : ''}
$reset\n
""");
    }
  }

  /// Logs details of an outgoing HTTP request.
  ///
  /// [options]: The RequestOptions object containing request information.
  /// [show]: Whether to display the request log.
  /// [showCurl]: Whether to display the CURL representation of the request.
  /// [showData]: Whether to include the request data in the log.
  static void dioInterceptorRequest({
    required RequestOptions options,
    required bool show,
    required bool showCurl,
    required bool showData,
  }) {
    if (show) {
      String? formattedData;
      try {
        if (options.data != null) {
          formattedData = formatJson(options.data, grey, orange, white);
        }
      } catch (e) {
        formattedData = 'Unable to format data: $e';
      }

      String formattedHeaders =
          formatJson(options.headers, grey, orange, white);

      String endpoint = extractEndpoint(
        options.uri.path,
      );

      log("""
${'-' * 20} ${applyColor('Request', white)} ${applyColor(endpoint, orange)} ${'-' * 20}\n
${applyColor('URL:', white)} ${applyColor(options.uri.toString(), orange)}
${applyColor('Method:', white)} ${applyColor(options.method, orange)}
${applyColor('Headers:', white)} $formattedHeaders
${formattedData != null && showData ? '${applyColor('Date:', white)} $formattedData\n' : ''}
${showCurl ? '${curlRepresentation(options)}\n' : ''}
$reset\n
""");
    }
  }

  /// Logs details of an incoming HTTP response.
  ///
  /// [response]: The Response object containing response information.
  /// [show]: Whether to display the response log.
  /// [showCurl]: Whether to display the CURL representation of the response.
  /// [showData]: Whether to include the response data in the log.
  static void dioInterceptorResponse({
    required Response response,
    required bool show,
    required bool showCurl,
    required bool showData,
  }) {
    if (show) {
      String? formattedData;
      try {
        if (response.data != null) {
          formattedData = formatJson(response.data, grey, cyan, white);
        }
      } catch (e) {
        formattedData = 'Unable to format data: $e';
      }

      String endpoint = extractEndpoint(
        response.requestOptions.uri.path,
      );

      log("""
${'-' * 20} ${applyColor('Response', white)} ${applyColor(endpoint, cyan)} ${'-' * 20}\n
${applyColor('URL:', white)} ${applyColor(response.requestOptions.uri.toString(), cyan)}
${applyColor('Method:', white)} ${applyColor(response.requestOptions.method, cyan)}
${formattedData != null && showData ? '${applyColor('Data:', white)} $formattedData\n' : ''}
${showCurl ? '${curlRepresentation(response.requestOptions)}\n' : ''}
$reset\n
""");
    }
  }

  /// Logs general information with a structured format.
  ///
  /// [title]: An optional title for the log.
  /// [body]: A list of LogInfoBody objects containing detailed log information.
  static void info({
    LogToolsInfoTitle? title,
    List<LogToolsInfoBody> body = const [],
  }) {
    List<LogToolsInfoBody> formattedBody = [];
    for (LogToolsInfoBody info in body) {
      if (info.value is Map<String, dynamic>) {
        final bodyKey = info.title;
        final bodyValue = formatJson(info.value, grey, cyan, white);
        formattedBody.add(LogToolsInfoBody(title: bodyKey, value: bodyValue));
      } else {
        final bodyKey = info.title;
        final bodyValue = applyColor(info.value.toString(), cyan);
        formattedBody.add(LogToolsInfoBody(title: bodyKey, value: bodyValue));
      }
    }

    log("""
${'-' * 20}${title != null ? ' ${applyColor(title.title, white)} ' : '--'}${title != null && title.value != null ? '${applyColor(title.value ?? '', cyan)} ' : '-'}${'-' * 20}\n
${formattedBody.map((info) => '${info.title != null ? '${applyColor(info.title!, white)}: ' : ''}${info.value}').join('\n')}
$reset\n
""");
  }
}
