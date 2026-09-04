import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Movie Detail Page'),
      ),
    );
  }
}
