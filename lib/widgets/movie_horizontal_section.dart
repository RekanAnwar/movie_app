import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/providers/providers.dart';
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
    final moviesFuture = ref.watch(
      moviesFutureProvider(
        MoviesFutureProviderParams(
          moviesType: moviesType,
        ),
      ),
    );

    return moviesFuture.when(
      data: (paginatedResponse) {
        final movies = paginatedResponse.data;

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
              child: ListView.separated(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                itemBuilder: (context, index) => MovieTile(
                  movie: movies[index],
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
