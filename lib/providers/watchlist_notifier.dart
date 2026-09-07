import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/dependencies/dependencies.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/toast_notifier.dart';
import 'package:movie_app/utils/logging.dart';

final watchlistNotifierProvider =
    NotifierProvider<WatchlistNotifier, List<Movie>>(
      WatchlistNotifier.new,
    );

class WatchlistNotifier extends Notifier<List<Movie>> {
  @override
  List<Movie> build() {
    final repository = ref.read(watchlistRepositoryProvider);

    return repository.getMovies();
  }

  Future<void> toggle(Movie movie) async {
    final repository = ref.read(watchlistRepositoryProvider);
    final toast = ref.read(toastNotifierProvider.notifier);

    try {
      final movies = await repository.toggle(movie);

      state = movies;

      final contains = movies.any((m) => m.id == movie.id);

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
    } catch (error, stackTrace) {
      talker.handle(error, stackTrace, 'Failed to update watchlist');

      toast.showError(
        title: 'Watchlist update failed',
        message: 'Could not update your watchlist. Please try again.',
      );
    }
  }
}
