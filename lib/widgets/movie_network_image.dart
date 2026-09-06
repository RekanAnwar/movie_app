import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/gen/gen.dart';
import 'package:movie_app/utils/utils.dart';

enum MovieImagePlaceholder {
  filmStrip,
  poster,
}

class MovieNetworkImage extends StatelessWidget {
  const MovieNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.topCenter,
    this.borderRadius,
    this.placeholder = MovieImagePlaceholder.filmStrip,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final BorderRadius? borderRadius;
  final MovieImagePlaceholder placeholder;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      final empty = _Placeholder(
        width: width,
        height: height,
        type: placeholder,
      );

      if (borderRadius == null) return empty;

      return ClipRRect(borderRadius: borderRadius!, child: empty);
    }

    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      fadeInDuration: const Duration(milliseconds: 200),
      fadeOutDuration: const Duration(milliseconds: 100),
      placeholder: (context, url) => _Placeholder(
        width: width,
        height: height,
        type: placeholder,
      ),
      errorBuilder: (context, error, stackTrace) => _Placeholder(
        width: width,
        height: height,
        type: placeholder,
      ),
    );

    if (borderRadius == null) return image;

    return ClipRRect(borderRadius: borderRadius!, child: image);
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    required this.type,
    this.width,
    this.height,
  });

  final MovieImagePlaceholder type;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      MovieImagePlaceholder.poster =>
        Assets.images.moviePosterPlaceholder.image(
          fit: BoxFit.cover,
          color: context.grey300,
          width: width ?? double.infinity,
          height: height ?? double.infinity,
        ),
      MovieImagePlaceholder.filmStrip => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.surface,
          border: Border.all(color: context.grey300),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Assets.images.filmStripPlaceholder.image(
          width: width != null ? width! - 2 : null,
          height: height != null ? height! - 2 : null,
        ),
      ),
    };
  }
}
