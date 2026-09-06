import 'package:carousel_slider/carousel_slider.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/pages/pages.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/movie_network_image.dart';
import 'package:movie_app/widgets/wave_shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FeaturedMoviesCarousel extends HookConsumerWidget {
  const FeaturedMoviesCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useValueNotifier(0);

    final moviesFuture = ref.watch(
      moviesFutureProvider(
        const MoviesFutureProviderParams(
          moviesType: MoviesType.trending,
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: moviesFuture.whenAnimated(
        data: (paginatedResponse) {
          final movies = paginatedResponse.data.take(5).toList();

          return Column(
            key: const ValueKey('featured-movies-carousel'),
            children: [
              CarouselSlider.builder(
                itemCount: movies.length,
                itemBuilder: (context, index, _) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _FeaturedMovieCard(movie: movies[index]),
                ),
                options: CarouselOptions(
                  onPageChanged: (index, _) {
                    if (currentIndex.value == index) return;

                    currentIndex.value = index;
                  },
                  height: 220,
                  autoPlay: true,
                  enlargeFactor: 0.15,
                  viewportFraction: 0.9,
                  clipBehavior: Clip.none,
                  enlargeCenterPage: true,
                ),
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder<int>(
                valueListenable: currentIndex,
                builder: (context, activeIndex, _) => AnimatedSmoothIndicator(
                  count: movies.length,
                  activeIndex: activeIndex,
                  effect: ExpandingDotsEffect(
                    spacing: 6,
                    dotWidth: 8,
                    dotHeight: 8,
                    expansionFactor: 2.5,
                    dotColor: context.grey300,
                    activeDotColor: context.primaryContainer,
                  ),
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => const SizedBox.shrink(),
        loading: () => const _FeaturedMoviesCarouselShimmer(
          key: ValueKey('featured-movies-carousel-shimmer'),
        ),
      ),
    );
  }
}

class _FeaturedMoviesCarouselShimmer extends HookWidget {
  const _FeaturedMoviesCarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useValueNotifier(0);

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: 5,
          itemBuilder: (context, index, _) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: WaveShimmer(
              height: 220,
              radius: 20,
            ),
          ),
          options: CarouselOptions(
            onPageChanged: (index, _) {
              if (currentIndex.value == index) return;

              currentIndex.value = index;
            },
            height: 220,
            enlargeFactor: 0.15,
            viewportFraction: 0.9,
            clipBehavior: Clip.none,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
          ),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder(
          valueListenable: currentIndex,
          builder: (context, value, child) => AnimatedSmoothIndicator(
            count: 5,
            activeIndex: value,
            effect: ExpandingDotsEffect(
              spacing: 6,
              dotWidth: 8,
              dotHeight: 8,
              expansionFactor: 2.5,
              dotColor: context.grey300,
              activeDotColor: context.primaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeaturedMovieCard extends StatelessWidget {
  const _FeaturedMovieCard({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MovieDetailPage(movie: movie)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            MovieNetworkImage(
              imageUrl: movie.fullBackdropUrl,
              placeholder: MovieImagePlaceholder.poster,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                    Colors.black87,
                  ],
                  stops: [0.35, 0.7, 1],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: context.primaryContainer,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Text(
                      'FEATURED',
                      style: context.labelSmall?.copyWith(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                        color: context.onPrimaryFixed,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.title.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 16,
                                  color: context.primaryContainer,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${movie.voteAverage.toStringAsFixed(1)}'
                                  '${movie.releaseDate != null ? '  •  ${DateFormat('yyyy').format(movie.releaseDate!)}' : ''}',
                                  style: context.bodySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            _GenreNames(movie: movie),
                          ],
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final isInWatchlist = ref.watch(
                            watchlistNotifierProvider.select(
                              (movies) => movies.any(
                                (m) => m.id == movie.id,
                              ),
                            ),
                          );

                          return IconButton(
                            onPressed: () async => ref
                                .read(watchlistNotifierProvider.notifier)
                                .toggle(movie),
                            style: IconButton.styleFrom(
                              side: BorderSide(color: context.primaryContainer),
                              foregroundColor: context.primaryContainer,
                              minimumSize: const Size(40, 40),
                              padding: EdgeInsets.zero,
                            ),
                            icon: Icon(
                              isInWatchlist
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_border_rounded,
                              size: 20,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenreNames extends ConsumerWidget {
  const _GenreNames({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genresFuture = ref.watch(genresFutureProvider);

    return genresFuture.when(
      data: (genres) {
        final genreNames = movie.genreNames(genres);

        if (genreNames.isEmpty) return const SizedBox.shrink();

        return Text(
          genreNames.join(' • '),
          style: context.bodySmall?.copyWith(
            color: Colors.white70,
          ),
        );
      },

      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}
