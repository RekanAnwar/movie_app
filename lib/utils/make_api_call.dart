import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movie_app/utils/logging.dart';
import 'package:movie_app/utils/result.dart';

Future<Result<T>> makeApiCall<T>(
  Future<T> Function() callback, {
  required String defaultErrorMessage,
  Duration timeout = const Duration(seconds: 20),
  Result<T>? Function(Object error)? onError,
}) async {
  const String kTimeoutMessage =
      'This is taking too long. Check your internet and try again.';
  const String kNetworkMessage =
      'No internet connection. Check your network and try again.';

  try {
    final data = await callback().timeout(
      timeout,
      onTimeout: () => throw TimeoutException(kTimeoutMessage, timeout),
    );

    return Result.success(data);
  } on TimeoutException catch (error, stackTrace) {
    talker.handle(error, stackTrace, kTimeoutMessage);

    return Result.failure(NetworkError(error.message ?? kTimeoutMessage));
  } on SocketException catch (error, stackTrace) {
    talker.handle(error, stackTrace, kNetworkMessage);

    return Result.failure(NetworkError(error.message));
  } on DioException catch (error, stackTrace) {
    talker.handle(error, stackTrace, defaultErrorMessage);

    final isNetwork = switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.connectionError => true,
      DioExceptionType.unknown when error.error is SocketException => true,
      _ => false,
    };

    if (isNetwork) return const Result.failure(NetworkError(kNetworkMessage));

    return Result.failure(error);
  } catch (error, stackTrace) {
    final result = onError?.call(error);

    talker.handle(error, stackTrace, defaultErrorMessage);

    return result ?? Result.failure(defaultErrorMessage);
  }
}
