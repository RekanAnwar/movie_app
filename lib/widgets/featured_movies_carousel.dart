import 'package:carousel_slider/carousel_slider.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FeaturedMoviesCarousel extends HookWidget {
  const FeaturedMoviesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useValueNotifier(0);

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _movies.length,
          itemBuilder: (context, index, _) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _FeaturedMovieCard(movie: _movies[index]),
          ),
          options: CarouselOptions(
            height: 220,
            autoPlay: true,
            enlargeFactor: 0.15,
            viewportFraction: 0.92,
            clipBehavior: Clip.none,
            enlargeCenterPage: true,
            onPageChanged: (index, _) {
              if (currentIndex.value == index) return;

              currentIndex.value = index;
            },
          ),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<int>(
          valueListenable: currentIndex,
          builder: (context, activeIndex, _) => AnimatedSmoothIndicator(
            count: _movies.length,
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
  }
}

class _FeaturedMovieCard extends StatelessWidget {
  const _FeaturedMovieCard({required this.movie});

  final _FeaturedMovie movie;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            movie.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => ColoredBox(color: context.grey800),
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
                                '${movie.rating}  •  ${movie.year}  •  ${movie.runtime}',
                                style: context.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            movie.genres,
                            style: context.bodySmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        side: BorderSide(color: context.primaryContainer),
                        foregroundColor: context.primaryContainer,
                        minimumSize: const Size(40, 40),
                        padding: EdgeInsets.zero,
                      ),
                      icon: const Icon(Icons.bookmark_border_rounded, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedMovie {
  const _FeaturedMovie({
    required this.title,
    required this.rating,
    required this.year,
    required this.runtime,
    required this.genres,
    required this.imageUrl,
  });

  final String title;
  final double rating;
  final int year;
  final String runtime;
  final String genres;
  final String imageUrl;
}

const _movies = [
  _FeaturedMovie(
    title: 'Interstellar',
    rating: 8.6,
    year: 2014,
    runtime: '169 min',
    genres: 'Sci-Fi • Adventure',
    imageUrl: 'https://image.tmdb.org/t/p/w780/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
  ),
  _FeaturedMovie(
    title: 'Inception',
    rating: 8.8,
    year: 2010,
    runtime: '148 min',
    genres: 'Action • Sci-Fi',
    imageUrl: 'https://image.tmdb.org/t/p/w780/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg',
  ),
  _FeaturedMovie(
    title: 'Dune',
    rating: 8.0,
    year: 2021,
    runtime: '155 min',
    genres: 'Sci-Fi • Adventure',
    imageUrl: 'https://image.tmdb.org/t/p/w780/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
  ),
  _FeaturedMovie(
    title: 'The Dark Knight',
    rating: 9.0,
    year: 2008,
    runtime: '152 min',
    genres: 'Action • Crime',
    imageUrl: 'https://image.tmdb.org/t/p/w780/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg',
  ),
];
