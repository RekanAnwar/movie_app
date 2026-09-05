import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';

class MovieHorizontalSection extends StatelessWidget {
  const MovieHorizontalSection({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: context.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 230,
          child: ListView.separated(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            itemBuilder: (context, index) => SizedBox(
              width: 120,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: Image.network(
                      switch (index % 6) {
                        0 =>
                          'https://image.tmdb.org/t/p/w780/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg',
                        1 =>
                          'https://image.tmdb.org/t/p/w780/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
                        2 =>
                          'https://image.tmdb.org/t/p/w780/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
                        3 =>
                          'https://image.tmdb.org/t/p/w780/Ab8mkHmkYADjU7wQiOkia9BzGvS.jpg',
                        4 =>
                          'https://image.tmdb.org/t/p/w780/q719jXXEzOoYaps6babgKnONONX.jpg',
                        5 =>
                          'https://image.tmdb.org/t/p/w780/oQRgyQCzcyZvE6w5heM9ktVY0LT.jpg',
                        int() =>
                          'https://image.tmdb.org/t/p/w780/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
                      },
                      width: 120,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 120,
                    child: Text(
                      'The Dark Knight',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const _MovieRating(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MovieRating extends StatelessWidget {
  const _MovieRating();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '2008',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.star_rounded,
                color: context.primaryContainer,
                size: 16,
              ),
              const SizedBox(width: 4),
              const Flexible(
                child: Text(
                  '8.5',
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
