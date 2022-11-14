import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:now_services/external/enums/type_request.dart';
import 'package:now_services/external/models/now_response.dart';
import 'package:now_services/external/models/now_response_error.dart';
import 'package:now_services/external/now_response.dart';
import 'package:now_services/external/now_services_abstraction.dart';

class NowServicesimpl implements NowServices {
  late String _host;
  Map<String, dynamic>? _header;
  http.Client? client;

  @override
  Future<NowResponseDataSource<S>?> callServiceResponse<S>(
    String host,
    TypeRequest rest,
    String path, {
    bool isHttps = true,
    bool isParse = false,
    String? jsonRequest,
    String? accessToken,
    int timeoutDefault = 60,
    String msgConnection = '',
    String uploadField = '',
    String msgTimeOut = 'Timeout on request',
    String msgFailure = 'Failure on request',
    Map<String, dynamic>? qParam,
    Map<String, String>? headers,
    bool isConvertJsonBytes = true,
    bool isConvertResponseBytes = true,
    bool isSendCookies = true,
    bool isUpdateCookies = true,
    String? token,
    String? contentTypeValue,
    S Function(dynamic json)? fromJson,
    bool isCache = false,
    bool isForceCall = false,
    bool isUpload = false,
    Uint8List? bytesUpload,
    String? fileNameUploadWithExtension,
  }) async {
    Uri url = Uri();
    if (isParse) {
      url = Uri.parse(host + path);
    } else if (isHttps) {
      url = Uri.https(
        host,
        path,
        qParam?.map(
          (key, value) => MapEntry(
            key,
            value.toString(),
          ),
        ),
      );
    } else {
      url = Uri.http(
        host,
        path,
        qParam?.map(
          (key, value) => MapEntry(
            key,
            value.toString(),
          ),
        ),
      );
    }

    // Inicializando lib http para obter resposta

    http.Response? response;

    // Inicializando cliente
    http.Client? httpClient = client ?? http.Client();

    try {
      final requestHeaders = _header ?? <String, String>{};
      response = response ?? await doRequest(
        client: httpClient,
        headers: requestHeaders as Map<String, String>,
        msgFailure: msgFailure,
        msgTimeOut: msgTimeOut,
        rest: rest,
        url: url,
        jsonRequest: jsonRequest,
        timeoutDefault: timeoutDefault,
      );

      if (response.statusCode == 200) {
        NowResponseDataSourceSuccess<S>(
          response: NowResponse<S>(
            statusCode: response.statusCode,
            headers: response.headers,
            isSuccess: true,
            contentLength: response.contentLength,
            data: response.body,
          ),
        );
      }
    } catch (error, stackTrace) {
      return NowResponseDataSourceError<S>(
        responseError: NowResponseError(
          message: error.toString(),
          error: error,
          stackTrace: stackTrace,
          responseHttp: response,
        ),
      );
    } finally {
      client?.close();
    }
    return null;
  }

  Future<http.Response> doRequest({
    required TypeRequest rest,
    required http.Client client,
    required Uri url,
    required Map<String, String> headers,
    String? jsonRequest,
    required String msgFailure,
    int timeoutDefault = 60,
    required String msgTimeOut,
  }) async {
    http.Response? responseLocal;
    final jsonBody = jsonRequest;
    final Duration durationTimeout = Duration(seconds: timeoutDefault);
    switch (rest) {
      case TypeRequest.POST:
        responseLocal = await client
            .post(url, headers: headers, body: jsonBody)
            .onError((error, stackTrace) => throw msgFailure)
            .timeout(durationTimeout, onTimeout: () => throw msgTimeOut);
        break;

      case TypeRequest.PUT:
        responseLocal = await client
            .put(url, headers: headers, body: jsonBody)
            .onError((error, stackTrace) => throw msgFailure)
            .timeout(durationTimeout, onTimeout: () => throw msgTimeOut);
        break;

      case TypeRequest.GET:
        responseLocal = await client
            .get(url, headers: headers)
            .onError((error, stackTrace) => throw msgFailure)
            .timeout(durationTimeout, onTimeout: () => throw msgTimeOut);
        break;

      case TypeRequest.DELETE:
        responseLocal = await client
            .delete(url, headers: headers, body: jsonBody)
            .onError((error, stackTrace) => throw msgFailure)
            .timeout(durationTimeout, onTimeout: () => throw msgTimeOut);
        break;
      case TypeRequest.PATCH:
        responseLocal = await client
            .patch(url, headers: headers, body: jsonBody)
            .onError((error, stackTrace) => throw msgFailure)
            .timeout(durationTimeout, onTimeout: () => throw msgTimeOut);
        break;
    }
    return responseLocal;
  }

  @override
  Map<String, dynamic>? getHeader() => _header;

  @override
  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  void setHeader(Map<String, dynamic> header) {
    _header = header;
  }

  @override
  void setHost(String host) {
    _host = host;
  }
}
