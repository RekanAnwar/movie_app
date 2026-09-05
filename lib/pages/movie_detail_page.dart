import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/movie_detail/movie_detail.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          MovieDetailHeader(movie: movie),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.bookmark_outline_rounded,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text('Add to Watchlist'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Overview',
                  style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  movie.overview,
                  style: context.bodyMedium?.copyWith(
                    color: context.grey700,
                  ),
                ),
                const SizedBox(height: 16),
                const MovieDetailSimilarSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
