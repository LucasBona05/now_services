import 'package:now_services/external/models/now_response.dart';
import 'package:now_services/external/now_response_use_case.dart';

import 'models/now_response_error.dart';
import 'now_response_service.dart';

abstract class NowResponseDataSource<S> extends NowResponseService<S>{}

class NowResponseDataSourceError<S> implements NowResponseDataSource<S> {
  NowResponseError responseError;

  NowResponseDataSourceError({required this.responseError});

  @override
  NowResponseUseCase<US> getResult<US>({
    NowResponseUseCaseError<US> Function(NowResponseError responseError)? onError,
    NowResponseUseCaseSuccess<US> Function(NowResponse<S> response)? onSuccess,
  }) {
    return onError!(responseError);
  }

  @override
  S? getData() {
    return null;
  }
}

class NowResponseDataSourceSuccess<S> implements NowResponseDataSource<S> {
  NowResponse<S> response;

  NowResponseDataSourceSuccess({
    required this.response,
  });

  @override
  NowResponseUseCase<US> getResult<US>({
    NowResponseUseCaseError<US> Function(NowResponseError responseError)? onError,
    NowResponseUseCaseSuccess<US> Function(NowResponse<S> response)? onSuccess,
  }) {
    return onSuccess!(response);
  }

  @override
  S? getData() {
    return response.data as S;
  }
}