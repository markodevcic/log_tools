import 'package:dio/dio.dart';
import 'package:log_tools/log_master.dart';

/// A custom Dio interceptor for logging requests and responses.
///
/// This interceptor uses the [LogTools] class to log request and response details,
/// as well as any errors that occur during the process.
class DioInterceptor extends Interceptor {
  /// Creates a new instance of [LogDioInterceptor].
  ///
  /// [showRequest]: Whether to show request logs.
  /// [showRequestCurl]: Whether to show the CURL representation of requests.
  /// [showRequestData]: Whether to include request data in the logs.
  /// [showResponse]: Whether to show response logs.
  /// [showResponseCurl]: Whether to show the CURL representation of responses.
  /// [showResponseData]: Whether to include response data in the logs.
  /// [showError]: Whether to show error logs.
  /// [showErrorData]: Whether to include error data in the logs.
  DioInterceptor({
    this.showRequest = true,
    this.showRequestCurl = true,
    this.showRequestData = true,
    this.showResponse = true,
    this.showResponseCurl = false,
    this.showResponseData = true,
    this.showError = true,
    this.showErrorData = true,
  });

  final bool showRequest;
  final bool showRequestCurl;
  final bool showRequestData;
  final bool showResponse;
  final bool showResponseCurl;
  final bool showResponseData;
  final bool showError;
  final bool showErrorData;

  // Log methods for requests, responses, and errors.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LogTools.dioInterceptorError(
        dioException: err, show: showError, showData: showErrorData);
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LogTools.dioInterceptorRequest(
      options: options,
      show: showRequest,
      showCurl: showRequestCurl,
      showData: showRequestData,
    );
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    LogTools.dioInterceptorResponse(
      response: response,
      show: showResponse,
      showCurl: showResponseCurl,
      showData: showResponseData,
    );
    return super.onResponse(response, handler);
  }
}
