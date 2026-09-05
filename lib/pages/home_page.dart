import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/featured_movies_carousel.dart';
import 'package:movie_app/widgets/movie_horizontal_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: CustomScrollView(
        slivers: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discover Movies',
                  style: context.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_border_rounded,
                    color: context.primaryContainer,
                    size: 28,
                  ),
                ),
              ],
            ),
          ).toSliver,
          const SizedBox(height: 16).toSliver,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: context.surfaceContainer,
                hintText: 'Search movies...',
                hintStyle: context.bodyMedium?.copyWith(color: context.grey500),
                prefixIcon: Icon(Icons.search_rounded, color: context.grey500),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.grey200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.grey200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.primaryContainer),
                ),
              ),
            ),
          ).toSliver,
          const SizedBox(height: 16).toSliver,
          const FeaturedMoviesCarousel().toSliver,
          const SizedBox(height: 16).toSliver,
          const MovieHorizontalSection(title: 'Trending Now').toSliver,
          const SizedBox(height: 16).toSliver,
          const MovieHorizontalSection(title: 'Popular').toSliver,
          const SizedBox(height: 16).toSliver,
          const MovieHorizontalSection(title: 'Now Playing').toSliver,
          const SizedBox(height: 16).toSliver,
          const MovieHorizontalSection(title: 'Upcoming').toSliver,
          const SizedBox(height: 16).toSliver,
          const MovieHorizontalSection(title: 'Top Rated').toSliver,
          const SizedBox(height: 16).toSliver,
        ],
      ),
    );
  }
}
