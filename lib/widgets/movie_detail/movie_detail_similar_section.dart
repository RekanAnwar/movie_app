import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/movie_tile.dart';

class MovieDetailSimilarSection extends ConsumerWidget {
  const MovieDetailSimilarSection({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstPageFuture = ref.watch(
      similarMoviesFutureProvider(
        SimilarMoviesFutureProviderParams(movieId: movieId),
      ),
    );

    return firstPageFuture.when(
      data: (firstPage) {
        final totalResults = firstPage.totalResults;

        if (totalResults == 0) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Similar Movies',
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 210,
              child: ListView.separated(
                clipBehavior: Clip.none,
                itemCount: totalResults,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final page = index ~/ moviesPageSize + 1;
                  final indexInPage = index % moviesPageSize;

                  final pageFuture = ref.watch(
                    similarMoviesFutureProvider(
                      SimilarMoviesFutureProviderParams(
                        movieId: movieId,
                        page: page,
                      ),
                    ),
                  );

                  return pageFuture.when(
                    data: (pageResponse) {
                      if (indexInPage >= pageResponse.data.length) {
                        return const SizedBox.shrink();
                      }

                      return MovieTile(
                        pushReplacement: true,
                        movie: pageResponse.data[indexInPage],
                      );
                    },
                    error: (error, stackTrace) => indexInPage == 0
                        ? _SimilarMovieTileError(
                            onRetry: () => ref.invalidate(
                              similarMoviesFutureProvider(
                                SimilarMoviesFutureProviderParams(
                                  movieId: movieId,
                                  page: page,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    loading: () => const _SimilarMovieTileShimmer(),
                  );
                },
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}

class _SimilarMovieTileShimmer extends StatelessWidget {
  const _SimilarMovieTileShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 140,
          height: 160,
          decoration: BoxDecoration(
            color: context.surfaceContainer,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 100,
          height: 14,
          decoration: BoxDecoration(
            color: context.surfaceContainer,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 80,
          height: 12,
          decoration: BoxDecoration(
            color: context.surfaceContainer,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
        ),
      ],
    );
  }
}

class _SimilarMovieTileError extends StatelessWidget {
  const _SimilarMovieTileError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: context.grey500,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(
              foregroundColor: context.primaryContainer,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
