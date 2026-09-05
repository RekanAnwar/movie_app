import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/widgets/movie_tile.dart';

class MovieHorizontalSection extends StatelessWidget {
  const MovieHorizontalSection({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
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
          height: 230,
          child: ListView.separated(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            itemBuilder: (context, index) => MovieTile(
              movie: Movie(
                id: index,
                title: 'Movie $index',
                overview: 'Overview $index',
                voteAverage: 8.5,
                releaseDate: DateTime.now(),
                genreIds: [
                  const Genre(id: 1, name: 'Action'),
                  const Genre(id: 2, name: 'Adventure'),
                  const Genre(id: 3, name: 'Fantasy'),
                ],
                posterPath:
                    'https://image.tmdb.org/t/p/w500/sw7mordbZxgITU877yTpZCud90M.jpg',
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
