import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/widgets.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  static final _movies = [
    Movie(
      id: 157336,
      title: 'Interstellar',
      overview: 'A team of explorers travel through a wormhole in space.',
      voteAverage: 8.6,
      releaseDate: DateTime(2014, 11, 7),
      posterPath:
          'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU9Sxkrft2.jpg',
      backdropPath:
          'https://image.tmdb.org/t/p/w780/rAiYTfj3gXpMa4QEy31rw9gsWa8.jpg',
    ),
    Movie(
      id: 155,
      title: 'The Dark Knight',
      overview: 'Batman raises the stakes in his war on crime.',
      voteAverage: 9.0,
      releaseDate: DateTime(2008, 7, 18),
      posterPath:
          'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      backdropPath:
          'https://image.tmdb.org/t/p/w780/hqkIcbrOHL86UncnHIsHVcVmzue.jpg',
    ),
    Movie(
      id: 27205,
      title: 'Inception',
      overview: 'A thief who steals corporate secrets through dream-sharing.',
      voteAverage: 8.8,
      releaseDate: DateTime(2010, 7, 16),
      posterPath:
          'https://image.tmdb.org/t/p/w500/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg',
      backdropPath:
          'https://image.tmdb.org/t/p/w780/s3TBrRGB1qnbsDlrXtTSqSnQMiH.jpg',
    ),
    Movie(
      id: 693134,
      title: 'Dune: Part Two',
      overview: 'Paul Atreides unites with Chani and the Fremen.',
      voteAverage: 8.3,
      releaseDate: DateTime(2024, 3),
      posterPath:
          'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
      backdropPath:
          'https://image.tmdb.org/t/p/w780/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg',
    ),
    Movie(
      id: 414906,
      title: 'The Batman',
      overview: 'Batman ventures into Gotham City\'s underworld.',
      voteAverage: 7.8,
      releaseDate: DateTime(2022, 3, 4),
      posterPath:
          'https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg',
      backdropPath:
          'https://image.tmdb.org/t/p/w780/b0PlkVZRMlmYfx36ZwCNHRQmlks.jpg',
    ),
    Movie(
      id: 872585,
      title: 'Oppenheimer',
      overview: 'The story of J. Robert Oppenheimer and the atomic bomb.',
      voteAverage: 8.3,
      releaseDate: DateTime(2023, 7, 21),
      posterPath:
          'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
      backdropPath:
          'https://image.tmdb.org/t/p/w780/rLb2cwF3Pazuxaj0sRXQ037tGI1.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Watchlist',
              style: context.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${_movies.length} movies',
              style: context.bodySmall?.copyWith(
                color: context.grey600,
              ),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        itemCount: _movies.length,
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: context.paddingBottom + 32,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 280,
          mainAxisSpacing: 20,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) => MovieTile(
          height: 230,
          width: double.infinity,
          movie: _movies[index],
        ),
      ),
    );
  }
}
