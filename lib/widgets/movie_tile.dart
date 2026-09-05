import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/utils/utils.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailPage(
            movie: Movie(
              id: movie.id,
              title: movie.title,
              overview: movie.overview,
              voteAverage: movie.voteAverage,
              releaseDate: movie.releaseDate,
              backdropPath: movie.backdropPath,
              posterPath: movie.posterPath,
              genreIds: movie.genreIds,
            ),
          ),
        ),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: SizedBox(
        width: 120,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Image.network(
                movie.backdropPath ?? '',
                width: 120,
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    ColoredBox(color: context.grey800),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 120,
              child: Text(
                movie.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const _MovieRating(),
          ],
        ),
      ),
    );
  }
}

class _MovieRating extends StatelessWidget {
  const _MovieRating();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '2008',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.star_rounded,
                color: context.primaryContainer,
                size: 16,
              ),
              const SizedBox(width: 4),
              const Flexible(
                child: Text(
                  '8.5',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
