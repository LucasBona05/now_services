import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class NowResponseError {
  final dynamic error;
  final RequestOptions? requestOptions;
  final Response<dynamic>? response;
  final http.Response? responseHttp;
  final DioErrorType? type;
  final StackTrace? stackTrace;
  final String? message;

  const NowResponseError({
    this.error,
    this.message,
    this.requestOptions,
    this.response,
    this.responseHttp,
    this.stackTrace,
    this.type,
  });

  @override
  String toString() =>
      '${super.toString()} \n ${error.toString()} \n $message} \n ${stackTrace.toString()} \n ${response.toString()}';
}
