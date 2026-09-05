import 'package:movie_app/dependencies/dependencies.dart';
import 'package:movie_app/models/models.dart';
import 'package:riverpod/riverpod.dart';

final similarMoviesFutureProvider =
    FutureProvider.family<PaginatedResponse<Movie>, int>(
      (ref, id) async {
        final movieRepository = ref.read(movieRepositoryProvider);

        final result = await movieRepository.getSimilarMovies(id: id);

        return result.getOrThrow();
      },
      name: 'similarMoviesFutureProvider',
    );
