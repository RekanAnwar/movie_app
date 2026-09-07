import 'package:movie_app/mappers/genre_mapper.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/logging.dart';

class MovieMapper {
  const MovieMapper._();

  static Movie? fromJson(Map<String, dynamic> json) {
    try {
      return Movie(
        id: json['id'] as int,
        title: json['title'] as String,
        overview: json['overview'] as String,
        voteAverage: json['vote_average'] as num,
        releaseDate: DateTime.tryParse(json['release_date'] as String? ?? ''),
        posterPath: json['poster_path'] as String?,
        backdropPath: json['backdrop_path'] as String?,
        genres: json['genre_ids'] != null
            ? (json['genre_ids'] as List<dynamic>)
                  .map((e) => e is int ? Genre(id: e) : GenreMapper.fromJson(e))
                  .whereType<Genre>()
                  .toList()
            : [],
      );
    } catch (error, stackTrace) {
      talker.handle(
        error,
        stackTrace,
        'Error mapping movie ${json['id']}: $error',
      );

      return null;
    }
  }

  static Map<String, dynamic> toJson(Movie movie) {
    return {
      'id': movie.id,
      'title': movie.title,
      'overview': movie.overview,
      'vote_average': movie.voteAverage,
      'release_date': movie.releaseDate?.toIso8601String(),
      'poster_path': movie.posterPath,
      'backdrop_path': movie.backdropPath,
      'genre_ids': movie.genres.map((e) => GenreMapper.toJson(e)).toList(),
    };
  }
}
