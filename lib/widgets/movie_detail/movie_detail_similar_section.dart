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

    return firstPageFuture.whenAnimated(
      data: (firstPage) {
        final totalResults = firstPage.totalResults;

        if (totalResults == 0) return const SizedBox.shrink();

        return Column(
          key: ValueKey('similar-movies-$movieId'),
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
              child: ListView.builder(
                clipBehavior: Clip.none,
                itemCount: totalResults,
                scrollDirection: Axis.horizontal,
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

                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: MovieTile(
                          pushReplacement: true,
                          movie: pageResponse.data[indexInPage],
                        ),
                      );
                    },
                    error: (error, stackTrace) => const SizedBox.shrink(),
                    loading: () => const MovieTileShimmer(),
                  );
                },
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => _SimilarMoviesSectionShimmer(
        key: ValueKey('similar-movies-shimmer-$movieId'),
      ),
    );
  }
}

class _SimilarMoviesSectionShimmer extends StatelessWidget {
  const _SimilarMoviesSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
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
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) => const MovieTileShimmer(),
          ),
        ),
      ],
    );
  }
}
