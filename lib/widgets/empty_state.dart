import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/gen/gen.dart';
import 'package:movie_app/utils/utils.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.onRetry,
    this.retryLabel = 'Retry',
  });

  final AssetGenImage image;
  final String title;
  final String description;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image.image(
            fit: BoxFit.cover,
            width: context.width,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: context.bodyMedium?.copyWith(
                color: context.grey600,
              ),
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            TextButton(
              onPressed: onRetry,
              style: TextButton.styleFrom(
                foregroundColor: context.primaryContainer,
              ),
              child: Text(retryLabel),
            ),
          ],
        ],
      ),
    );
  }
}
