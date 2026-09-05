import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/logging.dart';

class GenreMapper {
  const GenreMapper._();

  static Genre? fromJson(Map<String, dynamic> json) {
    try {
      return Genre(
        id: json['id'] as int,
        name: json['name'] as String?,
      );
    } catch (error, stackTrace) {
      talker.handle(
        error,
        stackTrace,
        'Error mapping genre ${json['id']}: $error',
      );

      return null;
    }
  }

  static Map<String, dynamic> toJson(Genre genre) {
    return {
      'id': genre.id,
      'name': genre.name,
    };
  }
}
