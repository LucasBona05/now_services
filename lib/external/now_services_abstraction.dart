import 'dart:typed_data';

import 'package:now_services/external/enums/type_request.dart';
import 'package:now_services/external/now_response.dart';

abstract class NowServices {
  Future<bool> isConnected();

  Future<NowResponseDataSource<T>?> callServiceResponse<T>(
      String host,
      TypeRequest rest,
      String path, {
        bool isHttps = true,
        bool isParse = false,
        String? jsonRequest,
        String? accessToken,
        int timeoutDefault,
        String msgConnection,
        String uploadField = '',
        String msgTimeOut,
        String msgFailure,
        Map<String, dynamic>? qParam,
        Map<String, String> headers,
        bool isConvertJsonBytes = true,
        bool isConvertResponseBytes = true,
        bool isSendCookies = true,
        bool isUpdateCookies = true,
        String? token,
        String? contentTypeValue,
        T Function(dynamic json)? fromJson,
        bool isCache = false,
        bool isForceCall = false,
        bool isUpload = false,
        Uint8List? bytesUpload,
        String? fileNameUploadWithExtension,
      });

  void setHost(String host);

  void setHeader(Map<String, dynamic> header);

  Map<String, dynamic>? getHeader();
}
