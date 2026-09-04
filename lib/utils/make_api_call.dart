import 'dart:async';

import 'package:movie_app/utils/result.dart';

Future<Result<T>> makeApiCall<T>(
  Future<T> Function() callback, {
  required String defaultErrorMessage,
  Duration timeout = const Duration(seconds: 20),
  Result<T>? Function(Object error)? onError,
}) async {
  const String kTimeoutMessage =
      'This is taking too long. Check your internet and try again.';

  try {
    final data = await callback().timeout(
      timeout,
      onTimeout: () => throw TimeoutException(kTimeoutMessage, timeout),
    );

    return Result.success(data);
  } on TimeoutException catch (error) {
    return Result.failure(error.message ?? kTimeoutMessage);
  } catch (error) {
    final result = onError?.call(error);

    return result ?? Result.failure(defaultErrorMessage);
  }
}
