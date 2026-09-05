import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/gen/gen.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/utils/utils.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    super.key,
    required this.movie,
    this.width = 140,
    this.height = 160,
    this.pushReplacement = false,
  });

  final Movie movie;
  final double width;
  final double height;
  final bool pushReplacement;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pushReplacement
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(movie: movie),
              ),
            )
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(movie: movie),
              ),
            ),
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Image.network(
                movie.fullPosterUrl,
                width: width,
                height: height,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (context, error, stackTrace) => Container(
                  decoration: BoxDecoration(
                    color: context.surface,
                    border: Border.all(color: context.grey300),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Assets.images.filmStripPlaceholder.image(
                    width: width - 2,
                    height: height - 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: width,
              child: Text(
                movie.title,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 4),
            _MovieRating(movie: movie),
          ],
        ),
      ),
    );
  }
}

class _MovieRating extends StatelessWidget {
  const _MovieRating({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (movie.releaseDate != null)
          Expanded(
            child: Text(
              DateFormat('yyyy').format(movie.releaseDate!),
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
              Flexible(
                child: Text(
                  movie.voteAverage.toStringAsFixed(1),
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
