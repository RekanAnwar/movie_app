import 'package:movie_app/mappers/genre_mapper.dart';
import 'package:movie_app/models/models.dart';

class MovieMapper {
  const MovieMapper._();

  static Movie fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      voteAverage: json['vote_average'] as double,
      releaseDate: DateTime.parse(json['release_date'] as String),
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: json['genre_ids'] != null
          ? (json['genre_ids'] as List<dynamic>)
                .map((e) => e is int ? Genre(id: e) : GenreMapper.fromJson(e))
                .toList()
          : [],
    );
  }

  static Map<String, dynamic> toJson(Movie movie) {
    return {
      'id': movie.id,
      'title': movie.title,
      'overview': movie.overview,
      'vote_average': movie.voteAverage,
      'release_date': movie.releaseDate.toIso8601String(),
      'poster_path': movie.posterPath,
      'backdrop_path': movie.backdropPath,
      'genre_ids': movie.genreIds.map((e) => GenreMapper.toJson(e)).toList(),
    };
  }
}
