abstract class NowResponseUseCase<T> {
  void getResult(
      {Function(dynamic data, String message)? onError,
      Function(T data, String message)? onSuccess}) {}

  T? getData() => null;
}

class NowResponseUseCaseError<T> implements NowResponseUseCase<T> {
  dynamic data;
  String message;

  NowResponseUseCaseError({this.data, required this.message});

  @override
  void getResult(
      {Function(dynamic data, String message)? onError,
      Function(T data, String message)? onSuccess}) {
    onError!(data, message);
  }

  @override
  T? getData() {
    return null;
  }
}

class NowResponseUseCaseSuccess<T> implements NowResponseUseCase<T> {
  T data;
  String message;

  NowResponseUseCaseSuccess({
    required this.data,
    this.message = '',
  });

  @override
  void getResult({
    Function(dynamic data, String message)? onError,
    Function(T data, String message)? onSuccess,
  }) {
    onSuccess!(data, message);
  }

  @override
  T? getData() {
    return data;
  }
}
