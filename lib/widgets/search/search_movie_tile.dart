import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/movie_network_image.dart';
import 'package:movie_app/widgets/wave_shimmer.dart';

class SearchMovieTile extends ConsumerWidget {
  const SearchMovieTile({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailPage(movie: movie),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            MovieNetworkImage(
              imageUrl: movie.fullPosterUrl,
              width: 80,
              height: 100,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${movie.releaseDate?.year ?? ''}',
                    style: context.bodySmall?.copyWith(
                      color: context.grey600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: context.primaryContainer,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: context.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final genresFuture = ref.watch(genresFutureProvider);

                      return genresFuture.when(
                        data: (allGenres) {
                          final names = movie.genreNames(allGenres);

                          if (names.isEmpty) return const SizedBox.shrink();

                          return Column(
                            children: [
                              const SizedBox(height: 6),
                              Text(
                                names.join(' • '),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.bodySmall?.copyWith(
                                  color: context.grey600,
                                ),
                              ),
                            ],
                          );
                        },
                        error: (error, stackTrace) => const SizedBox.shrink(),
                        loading: () => const SizedBox.shrink(),
                      );
                    },
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final isInWatchlist = ref.watch(
                  watchlistNotifierProvider.select(
                    (movies) => movies.any(
                      (m) => m.id == movie.id,
                    ),
                  ),
                );

                return IconButton(
                  onPressed: () async => ref
                      .read(watchlistNotifierProvider.notifier)
                      .toggle(movie),
                  style: IconButton.styleFrom(
                    iconSize: 28,
                    foregroundColor: context.primaryContainer,
                  ),
                  icon: Icon(
                    isInWatchlist
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SearchMovieTileShimmer extends StatelessWidget {
  const SearchMovieTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          WaveShimmer(
            width: 80,
            height: 100,
            radius: 12,
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WaveShimmer(
                  width: 100,
                  height: 20,
                  radius: 4,
                ),
                SizedBox(height: 4),
                WaveShimmer(
                  width: 40,
                  height: 16,
                  radius: 4,
                ),
                SizedBox(height: 6),
                WaveShimmer(
                  width: 48,
                  height: 16,
                  radius: 4,
                ),
                SizedBox(height: 6),
                WaveShimmer(
                  width: 140,
                  height: 16,
                  radius: 4,
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          WaveShimmer(
            width: 40,
            height: 40,
            radius: 20,
          ),
          SizedBox(width: 4),
        ],
      ),
    );
  }
}
