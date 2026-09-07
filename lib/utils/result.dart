sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;

  const factory Result.failure(
    Object error, {
    String? code,
  }) = Failure<T>;

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => switch (this) {
    Success(:final data) => data,
    Failure() => null,
  };

  String? get messageOrNull => switch (this) {
    Success() => null,
    Failure(:final error) => error.toString(),
  };

  R when<R>(
    R Function(Object error) onFailure,
    R Function(T data) onSuccess,
  );

  void onFailure(void Function(Object error) action) {
    if (this case Failure(:final error)) {
      action(error);
    }
  }

  void onSuccess(void Function(T data) action) {
    if (this case Success(:final data)) {
      action(data);
    }
  }

  T getOrThrow() => switch (this) {
    Success(:final data) => data,
    Failure(:final error) => throw error,
  };
}

final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;

  @override
  R when<R>(
    R Function(Object error) onFailure,
    R Function(T data) onSuccess,
  ) => onSuccess(data);
}

final class Failure<T> extends Result<T> {
  const Failure(this.error, {this.code});

  final Object error;
  final String? code;

  @override
  R when<R>(
    R Function(Object error) onFailure,
    R Function(T data) onSuccess,
  ) => onFailure(error);
}

class NetworkError implements Exception {
  const NetworkError([
    this.message = 'No internet connection',
  ]);

  final Object message;

  @override
  String toString() => message.toString();
}
