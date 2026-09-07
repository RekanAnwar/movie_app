import 'dart:convert';

import 'package:movie_app/mappers/mappers.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchlistRepository {
  const WatchlistRepository(this._prefs);

  static const _storageKey = 'watchlist_movies';

  final SharedPreferences _prefs;

  List<Movie> getMovies() {
    final raw = _prefs.getString(_storageKey);

    if (raw == null || raw.isEmpty) return const [];

    try {
      final decoded = jsonDecode(raw) as List<dynamic>;

      return decoded
          .map((e) => MovieMapper.fromJson(e as Map<String, dynamic>))
          .whereType<Movie>()
          .toList();
    } catch (error, stackTrace) {
      talker.handle(error, stackTrace, 'Failed to read watchlist');

      return const [];
    }
  }

  Future<List<Movie>> toggle(Movie movie) async {
    var movies = getMovies();

    final contains = movies.any((m) => m.id == movie.id);

    if (contains) {
      movies = await _removeMovie(movie.id);
    } else {
      movies = await _addMovie(movie);
    }

    return movies;
  }

  Future<List<Movie>> _addMovie(Movie movie) async {
    final movies = getMovies();

    if (movies.any((m) => m.id == movie.id)) return movies;

    final updated = [movie, ...movies];

    await _saveMovies(updated);

    return updated;
  }

  Future<List<Movie>> _removeMovie(int id) async {
    final movies = getMovies();
    final updated = movies.where((movie) => movie.id != id).toList();

    await _saveMovies(updated);

    return updated;
  }

  Future<void> _saveMovies(List<Movie> movies) async {
    final encodedMovies = movies.map(MovieMapper.toJson).toList();
    final encoded = jsonEncode(encodedMovies);

    final saved = await _prefs.setString(_storageKey, encoded);

    if (!saved) throw Exception('Failed to save watchlist');
  }
}
