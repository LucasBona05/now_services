class NowResponse<T> {
  final T? data;
  final int? statusCode;
  final Map<String, dynamic>? headers;
  final int? contentLength;
  final bool isSuccess;
  final String? message;

  NowResponse({
    this.data,
    this.statusCode,
    this.headers,
    this.contentLength,
    this.isSuccess = false,
    this.message,
  });
}
