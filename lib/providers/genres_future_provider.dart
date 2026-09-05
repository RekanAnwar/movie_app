import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/dependencies/dependencies.dart';
import 'package:movie_app/models/models.dart';

final genresFutureProvider = FutureProvider<List<Genre>>(
  (ref) async {
    final genreRepository = ref.read(genreRepositoryProvider);

    final result = await genreRepository.getGenres();

    return result.getOrThrow();
  },
  name: 'genresFutureProvider',
);
