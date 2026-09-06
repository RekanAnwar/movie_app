import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/movie_network_image.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          movie.genreNames(allGenres);

                          return Column(
                            children: [
                              const SizedBox(height: 6),
                              Text(
                                movie.genreNames(allGenres).join(' • '),
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
                    side: BorderSide(color: context.primaryContainer),
                    foregroundColor: context.primaryContainer,
                    minimumSize: const Size(40, 40),
                    padding: EdgeInsets.zero,
                  ),
                  icon: Icon(
                    isInWatchlist
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    size: 20,
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
