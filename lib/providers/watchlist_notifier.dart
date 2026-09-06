import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/dependencies/dependencies.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/toast_notifier.dart';

final watchlistNotifierProvider =
    NotifierProvider<WatchlistNotifier, List<Movie>>(
      WatchlistNotifier.new,
    );

class WatchlistNotifier extends Notifier<List<Movie>> {
  @override
  List<Movie> build() {
    final repository = ref.read(watchlistRepositoryProvider);

    final movies = repository.getMovies();

    return movies;
  }

  Future<void> toggle(Movie movie) async {
    final repository = ref.read(watchlistRepositoryProvider);

    final movies = await repository.toggle(movie);

    state = movies;

    final contains = movies.any((m) => m.id == movie.id);
    final toast = ref.read(toastNotifierProvider.notifier);

    if (contains) {
      toast.showSuccess(
        title: 'Added to watchlist',
        message: movie.title,
      );
    } else {
      toast.showInfo(
        title: 'Removed from watchlist',
        message: movie.title,
      );
    }
  }
}
