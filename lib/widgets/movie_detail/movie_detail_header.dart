import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';

class MovieDetailHeader extends StatelessWidget {
  const MovieDetailHeader({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Image.network(
            movie.backdropPath ?? '',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) =>
                ColoredBox(color: context.grey800),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: context.isDark
                    ? [
                        context.surface.withValues(alpha: 0),
                        context.surface.withValues(alpha: 0.7),
                        context.surface.withValues(alpha: 0.9),
                        context.surface.withValues(alpha: 0.95),
                        context.surface.withValues(alpha: 0.97),
                        context.surface.withValues(alpha: 0.98),
                        context.surface.withValues(alpha: 0.99),
                        context.surface,
                      ]
                    : [
                        context.surface.withValues(alpha: 0),
                        context.surface.withValues(alpha: 0.95),
                        context.surface.withValues(alpha: 0.99),
                        context.surface,
                      ],
                stops: context.isDark
                    ? const [0.3, 0.6, 0.8, 0.85, 0.9, 0.95, 0.99, 1.0]
                    : const [0.5, 0.9, 0.95, 1.0],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 0,
            bottom: -50,
            child: _MovieDetailInfo(movie: movie),
          ),
          Positioned(
            left: 16,
            top: context.paddingTop,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: context.grey400),
                color: context.surface.withValues(alpha: 0.7),
              ),
              child: BackButton(color: context.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieDetailInfo extends StatelessWidget {
  const _MovieDetailInfo({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Image.network(
            movie.posterPath ?? '',
            width: 120,
            height: 160,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                ColoredBox(color: context.grey800),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 18,
                    color: context.primaryContainer,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      '${movie.voteAverage.toStringAsFixed(1)}'
                      '  •  ${movie.releaseDate.year}'
                      '  •  2h 49m',
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              if (movie.genreIds.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final genre in movie.genreIds)
                      if (genre.name != null && genre.name!.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: context.grey300),
                            color: context.grey200,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: Text(
                            genre.name!,
                            style: context.labelMedium?.copyWith(
                              color: context.grey700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
