import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/utils/utils.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final genres = movie.genreIds
        .map((genre) => genre.name)
        .whereType<String>()
        .where((name) => name.isNotEmpty)
        .join(' • ');

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
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.network(
                movie.fullPosterUrl,
                width: 72,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => ColoredBox(
                  color: context.grey200,
                  child: SizedBox(
                    width: 72,
                    height: 100,
                    child: Icon(
                      Icons.movie_rounded,
                      color: context.grey500,
                    ),
                  ),
                ),
              ),
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
                  if (genres.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      genres,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodySmall?.copyWith(
                        color: context.grey600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.bookmark_border_rounded,
                color: context.primaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
