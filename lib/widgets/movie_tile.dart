import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/widgets/movie_network_image.dart';
import 'package:movie_app/widgets/wave_shimmer.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    super.key,
    required this.movie,
    this.width = 140,
    this.height = 160,
    this.pushReplacement = false,
    this.topRightAction,
  });

  final Movie movie;
  final double width;
  final double height;
  final bool pushReplacement;
  final Widget? topRightAction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pushReplacement
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(movie: movie),
              ),
            )
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(movie: movie),
              ),
            ),
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
        bottom: Radius.circular(6),
      ),
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            Stack(
              children: [
                MovieNetworkImage(
                  width: width,
                  height: height,
                  imageUrl: movie.fullPosterUrl,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                if (topRightAction != null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: topRightAction!,
                  ),
              ],
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: width,
              child: Text(
                movie.title,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 4),
            _MovieRating(movie: movie),
          ],
        ),
      ),
    );
  }
}

class _MovieRating extends StatelessWidget {
  const _MovieRating({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (movie.releaseDate != null)
          Expanded(
            child: Text(
              DateFormat('yyyy').format(movie.releaseDate!),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.star_rounded,
                color: context.primaryContainer,
                size: 16,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  movie.voteAverage.toStringAsFixed(1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MovieTileShimmer extends StatelessWidget {
  const MovieTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 140,
      height: 210,
      child: Column(
        children: [
          WaveShimmer(
            width: 140,
            height: 160,
            radius: 16,
          ),
          SizedBox(height: 6),
          WaveShimmer(
            width: 140,
            height: 20,
            radius: 4,
          ),
          SizedBox(height: 4),
          SizedBox(
            width: 140,
            height: 20,
            child: Row(
              children: [
                WaveShimmer(
                  width: 70,
                  height: 20,
                  radius: 4,
                ),
                Spacer(),
                WaveShimmer(
                  radius: 4,
                  width: 40,
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
