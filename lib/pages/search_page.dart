import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/search/search.dart';

class SearchPage extends SearchDelegate<Movie?> {
  SearchPage()
    : super(
        searchFieldLabel: 'Search movies...',
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
      );

  static final _movies = [
    Movie(
      id: 19995,
      title: 'Avatar',
      overview:
          'A paraplegic Marine dispatched to the moon Pandora on a unique mission.',
      voteAverage: 7.8,
      releaseDate: DateTime(2009, 12, 18),
      posterPath:
          'https://image.tmdb.org/t/p/w500/jRXYjXNq0Cs2TcJjLkqP5XqY0K0.jpg',
      backdropPath:
          'https://image.tmdb.org/t/p/w780/Yc9q6QYX6NgmCN0ZFXypNbX9rr.jpg',
      genreIds: const [
        Genre(id: 28, name: 'Action'),
        Genre(id: 12, name: 'Adventure'),
        Genre(id: 14, name: 'Fantasy'),
      ],
    ),
    Movie(
      id: 76600,
      title: 'Avatar: The Way of Water',
      overview:
          'Jake Sully lives with his newfound family formed on the extrasolar moon Pandora.',
      voteAverage: 7.6,
      releaseDate: DateTime(2022, 12, 16),
      posterPath:
          'https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9JnNV.jpg',
      backdropPath:
          'https://image.tmdb.org/t/p/w780/s16H6tpK2utEQqdEmGaWseXwetE.jpg',
      genreIds: const [
        Genre(id: 28, name: 'Action'),
        Genre(id: 12, name: 'Adventure'),
        Genre(id: 14, name: 'Fantasy'),
      ],
    ),
    Movie(
      id: 246655,
      title: 'Avatar: The Last Airbender',
      overview:
          'The world is divided into four nations — each identified by a unique natural element.',
      voteAverage: 7.2,
      releaseDate: DateTime(2024, 2, 22),
      posterPath:
          'https://image.tmdb.org/t/p/w500/cUWMq7a8ZRJA42iFvZi6U8Y5ZbA.jpg',
      backdropPath:
          'https://image.tmdb.org/t/p/w780/9BBTo63ANSmhC4e6r62OJFuK2L6.jpg',
      genreIds: const [
        Genre(id: 10759, name: 'Action & Adventure'),
        Genre(id: 10765, name: 'Sci-Fi & Fantasy'),
      ],
    ),
    Movie(
      id: 83533,
      title: 'Avatar: The Next Shadow',
      overview: 'A graphic novel continuation of the Avatar universe.',
      voteAverage: 7.0,
      releaseDate: DateTime(2021),
      posterPath: '',
      backdropPath: '',
      genreIds: const [
        Genre(id: 16, name: 'Animation'),
        Genre(id: 14, name: 'Fantasy'),
      ],
    ),
    Movie(
      id: 268896,
      title: 'Avatar Spirits',
      overview:
          'Documentary exploring the creation of Avatar: The Last Airbender.',
      voteAverage: 7.9,
      releaseDate: DateTime(2010, 9, 13),
      posterPath: '',
      backdropPath: '',
      genreIds: const [
        Genre(id: 99, name: 'Documentary'),
      ],
    ),
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return context.theme.copyWith(
      appBarTheme: context.appBarTheme.copyWith(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: context.surface,
        foregroundColor: context.onSurface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: context.surfaceContainer,
        hintStyle: context.bodyMedium?.copyWith(
          color: context.onSurface.withValues(alpha: 0.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.primaryContainer),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        onPressed: query.isEmpty ? null : () => query = '',
        icon: Icon(
          Icons.close_rounded,
          color: query.isEmpty ? context.grey200 : context.grey700,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back_rounded, color: context.onSurface),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchBody(
      query: query,
      results: _filteredMovies(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchBody(
      query: query,
      results: _filteredMovies(),
    );
  }

  List<Movie> _filteredMovies() {
    final q = query.trim().toLowerCase();

    if (q.isEmpty) return const [];

    return _movies
        .where((movie) => movie.title.toLowerCase().contains(q))
        .toList();
  }
}
