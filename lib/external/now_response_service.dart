import 'package:now_services/external/now_response_use_case.dart';

import 'models/now_response.dart';
import 'models/now_response_error.dart';

abstract class NowResponseService<S> {
  NowResponseUseCase<US> getResult<US>({
    NowResponseUseCaseError<US> Function(NowResponseError responseError)? onError,
    NowResponseUseCaseSuccess<US> Function(NowResponse<S> response)? onSuccess,
  });

  S? getData();
}

class NowResponseServiceError<S> implements NowResponseService<S> {
  NowResponseError responseError;

  NowResponseServiceError({required this.responseError});

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

class NowResponseServiceSuccess<S> implements NowResponseService<S> {
  NowResponse<S> response;

  NowResponseServiceSuccess({
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
