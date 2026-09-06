import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/widgets/movie_tile.dart';

class MovieDetailSimilarSection extends ConsumerWidget {
  const MovieDetailSimilarSection({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarMoviesFuture = ref.watch(
      similarMoviesFutureProvider(movieId),
    );

    return similarMoviesFuture.when(
      data: (paginatedResponse) {
        final similarMovies = paginatedResponse.data;

        if (similarMovies.isEmpty) return const SizedBox.shrink();

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
                itemCount: similarMovies.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) => MovieTile(
                  pushReplacement: true,
                  movie: similarMovies[index],
                ),
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
