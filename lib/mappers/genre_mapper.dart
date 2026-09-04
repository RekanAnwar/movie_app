import 'package:movie_app/models/models.dart';

class GenreMapper {
  const GenreMapper._();

  static Genre fromJson(Map<String, dynamic> json) {
    return Genre(id: json['id'] as int, name: json['name'] as String?);
  }

  static Map<String, dynamic> toJson(Genre genre) {
    return {
      'id': genre.id,
      'name': genre.name,
    };
  }
}
