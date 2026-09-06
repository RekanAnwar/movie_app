import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/movie_tile.dart';

class MovieHorizontalSection extends ConsumerWidget {
  const MovieHorizontalSection({
    super.key,
    required this.title,
    required this.moviesType,
  });

  final String title;
  final MoviesType moviesType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstPageFuture = ref.watch(
      moviesFutureProvider(
        MoviesFutureProviderParams(
          moviesType: moviesType,
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 210,
          child: Consumer(
            builder: (context, ref, child) {
              return firstPageFuture.whenAnimated(
                data: (firstPage) {
                  final totalResults = firstPage.totalResults;

                  return ListView.separated(
                    key: ValueKey('movie-horizontal-section-$moviesType'),
                    itemCount: totalResults,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 20),
                    itemBuilder: (context, index) {
                      final page = index ~/ moviesPageSize + 1;
                      final indexInPage = index % moviesPageSize;

                      final pageFuture = ref.watch(
                        moviesFutureProvider(
                          MoviesFutureProviderParams(
                            page: page,
                            moviesType: moviesType,
                          ),
                        ),
                      );

                      return pageFuture.when(
                        data: (pageResponse) {
                          if (indexInPage >= pageResponse.data.length) {
                            return const SizedBox.shrink();
                          }

                          return MovieTile(
                            movie: pageResponse.data[indexInPage],
                          );
                        },
                        error: (error, stackTrace) => indexInPage == 0
                            ? _MovieTileError(
                                onRetry: () => ref.invalidate(
                                  moviesFutureProvider(
                                    MoviesFutureProviderParams(
                                      page: page,
                                      moviesType: moviesType,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        loading: () => const MovieTileShimmer(),
                      );
                    },
                  );
                },
                error: (error, stackTrace) => Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _MovieTileError(
                      onRetry: () => ref.invalidate(
                        moviesFutureProvider(
                          MoviesFutureProviderParams(
                            moviesType: moviesType,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                loading: () => _MovieHorizontalSectionShimmer(
                  key: ValueKey(
                    'movie-horizontal-section-shimmer-$moviesType',
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MovieHorizontalSectionShimmer extends StatelessWidget {
  const _MovieHorizontalSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      separatorBuilder: (context, index) => const SizedBox(width: 20),
      itemBuilder: (context, index) => const MovieTileShimmer(),
    );
  }
}

class _MovieTileError extends StatelessWidget {
  const _MovieTileError({required this.onRetry});

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
