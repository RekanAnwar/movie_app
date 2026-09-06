import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/gen/gen.dart';
import 'package:movie_app/pages/search_page.dart';
import 'package:movie_app/pages/watchlist_page.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/empty_state.dart';
import 'package:movie_app/widgets/featured_movies_carousel.dart';
import 'package:movie_app/widgets/movie_horizontal_section.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: RefreshIndicator(
        onRefresh: () async => ref
          ..invalidate(moviesFutureProvider)
          ..invalidate(genresFutureProvider)
          ..invalidate(similarMoviesFutureProvider),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover Movies',
                    style: context.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WatchlistPage(),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: context.primaryContainer,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    label: const Text('Watchlist'),
                    icon: const Icon(Icons.watch_later),
                  ),
                ],
              ),
            ).toSliver,
            const SizedBox(height: 16).toSliver,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onTap: () => showSearch(
                  context: context,
                  delegate: SearchPage(),
                ),
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: context.surfaceContainer,
                  hintText: 'Search movies...',
                  hintStyle: context.bodyMedium?.copyWith(
                    color: context.grey500,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: context.grey500,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: context.grey200),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: context.grey200),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: context.grey200),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
            ).toSliver,
            const SizedBox(height: 16).toSliver,
            Consumer(
              builder: (context, ref, child) {
                final isMoviesEmpty = ref.watch(
                  homeMoviesStatusProvider.select(
                    (status) => status == HomeMoviesStatus.empty,
                  ),
                );

                if (isMoviesEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyState(
                      onRetry: () => ref.invalidate(moviesFutureProvider),
                      image: Assets.images.emptyMovies,
                      title: 'No movies found',
                      description:
                          'We couldn\'t load any movies right now. Pull to refresh or try again.',
                    ),
                  );
                }

                return SliverMainAxisGroup(
                  slivers: [
                    const FeaturedMoviesCarousel().toSliver,
                    const MovieHorizontalSection(
                      title: 'Trending Now',
                      moviesType: MoviesType.trending,
                    ).toSliver,
                    const MovieHorizontalSection(
                      title: 'Popular',
                      moviesType: MoviesType.popular,
                    ).toSliver,
                    const MovieHorizontalSection(
                      title: 'Now Playing',
                      moviesType: MoviesType.nowPlaying,
                    ).toSliver,
                    const MovieHorizontalSection(
                      title: 'Upcoming',
                      moviesType: MoviesType.upcoming,
                    ).toSliver,
                    const MovieHorizontalSection(
                      title: 'Top Rated',
                      moviesType: MoviesType.topRated,
                    ).toSliver,
                    SizedBox(height: context.paddingBottom + 32).toSliver,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
