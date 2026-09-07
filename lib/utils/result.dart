sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;

  const factory Result.failure(Object error) = Failure<T>;

  T getOrThrow() => switch (this) {
    Success(:final data) => data,
    Failure(:final error) => throw error,
  };
}

final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);

  final Object error;
}

class NetworkError implements Exception {
  const NetworkError([
    this.message = 'No internet connection',
  ]);

  final Object message;

  @override
  String toString() => message.toString();
}
