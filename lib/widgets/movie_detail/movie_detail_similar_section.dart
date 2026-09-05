import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/widgets/movie_tile.dart';

class MovieDetailSimilarSection extends StatelessWidget {
  const MovieDetailSimilarSection({super.key});

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
          height: 230,
          child: ListView.separated(
            itemCount: 10,
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) => MovieTile(
              movie: Movie(
                id: index,
                title: 'Movie $index',
                overview: 'Overview $index',
                voteAverage: index.toDouble(),
                releaseDate: DateTime.now(),
                backdropPath:
                    'https://image.tmdb.org/t/p/w500/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
