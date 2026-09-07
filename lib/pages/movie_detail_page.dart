import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/providers.dart';
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
        physics: const ClampingScrollPhysics(),
        children: [
          MovieDetailHeader(movie: movie),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _WatchlistButton(movie: movie),
                const SizedBox(height: 16),
                if (movie.overview.isNotEmpty) ...[
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
                ],
                MovieDetailSimilarSection(movieId: movie.id),
                SizedBox(height: context.paddingBottom + 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WatchlistButton extends ConsumerWidget {
  const _WatchlistButton({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInWatchlist = ref.watch(
      watchlistNotifierProvider.select(
        (movies) => movies.any((m) => m.id == movie.id),
      ),
    );

    return FilledButton(
      onPressed: () async =>
          ref.read(watchlistNotifierProvider.notifier).toggle(movie),
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isInWatchlist
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_outlined,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            isInWatchlist ? 'Remove from Watchlist' : 'Add to Watchlist',
          ),
        ],
      ),
    );
  }
}
