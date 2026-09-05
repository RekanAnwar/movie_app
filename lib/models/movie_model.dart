import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/constants/constants.dart';
import 'package:movie_app/models/genres_model.dart';

class Movie extends Equatable {
  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.voteAverage,
    this.releaseDate,
    this.posterPath,
    this.backdropPath,
    this.genreIds = const [],
  });

  final int id;
  final String title;
  final String overview;
  final num voteAverage;
  final DateTime? releaseDate;
  final String? posterPath;
  final String? backdropPath;
  final List<Genre> genreIds;

  @override
  List<Object?> get props => [
    id,
    title,
    overview,
    voteAverage,
    releaseDate,
    posterPath,
    backdropPath,
    genreIds,
  ];

  String get fullPosterUrl =>
      posterPath != null ? '${Urls.imageUrl}$posterPath' : '';
  String get fullBackdropUrl =>
      backdropPath != null ? '${Urls.backdropUrl}$backdropPath' : '';

  List<String> genreNames(List<Genre> genres) => genreIds
      .map((e) => genres.firstWhereOrNull((genre) => genre.id == e.id)?.name)
      .whereType<String>()
      .toList();
}
