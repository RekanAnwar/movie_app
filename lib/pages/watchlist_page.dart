import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/widgets.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Watchlist',
              style: context.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final length = ref.watch(
                  watchlistNotifierProvider.select(
                    (value) => value.length,
                  ),
                );

                if (length == 0) return const SizedBox.shrink();

                return Text(
                  '$length ${length == 1 ? 'movie' : 'movies'}',
                  style: context.bodySmall?.copyWith(
                    color: context.grey600,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final movies = ref.watch(watchlistNotifierProvider);

          return movies.isEmpty
              ? Center(
                  child: Text(
                    'No movies in your watchlist yet',
                    style: context.bodyMedium?.copyWith(color: context.grey600),
                  ),
                )
              : GridView.builder(
                  itemCount: movies.length,
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: context.paddingBottom + 32,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 280,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) => MovieTile(
                    height: 230,
                    width: double.infinity,
                    movie: movies[index],
                    topRightAction: IconButton(
                      onPressed: () => ref
                          .read(watchlistNotifierProvider.notifier)
                          .toggle(movies[index]),
                      style: IconButton.styleFrom(
                        shape: CircleBorder(
                          side: BorderSide(color: context.outline),
                        ),
                        minimumSize: const Size(40, 40),
                        backgroundColor: context.surface.withValues(
                          alpha: 0.85,
                        ),
                        foregroundColor: context.primaryContainer,
                      ),
                      icon: const Icon(
                        Icons.bookmark_rounded,
                        size: 20,
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
