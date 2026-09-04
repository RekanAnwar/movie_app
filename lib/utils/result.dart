sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;

  const factory Result.failure(
    String message, {
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
    Failure(:final message) => message,
  };

  R when<R>(
    R Function(String message) onFailure,
    R Function(T data) onSuccess,
  );

  void onFailure(void Function(String message) action) {
    if (this case Failure(:final message)) {
      action(message);
    }
  }

  void onSuccess(void Function(T data) action) {
    if (this case Success(:final data)) {
      action(data);
    }
  }

  T getOrThrow() => switch (this) {
    Success(:final data) => data,
    Failure(:final message) => throw Exception(message),
  };
}

final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;

  @override
  R when<R>(
    R Function(String message) onFailure,
    R Function(T data) onSuccess,
  ) => onSuccess(data);
}

final class Failure<T> extends Result<T> {
  const Failure(this.message, {this.code});

  final String message;
  final String? code;

  @override
  R when<R>(
    R Function(String message) onFailure,
    R Function(T data) onSuccess,
  ) => onFailure(message);
}
