import 'package:flutter/material.dart';
import 'package:movie_app/gen/gen.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/empty_state.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.error,
    required this.onRetry,
    this.retryLabel = 'Retry',
  });

  final Object error;
  final VoidCallback onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final isOffline = error is NetworkError;

    return EmptyState(
      image: isOffline
          ? Assets.images.noInternetState
          : Assets.images.errorState,
      title: isOffline ? 'No internet connection' : 'Something went wrong',
      description: isOffline
          ? 'Please check your connection and try again.'
          : 'An unexpected error occurred. Please try again.',
      onRetry: onRetry,
      retryLabel: retryLabel,
    );
  }
}
