import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/search/search_result_tile.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({
    super.key,
    required this.query,
    required this.results,
  });

  final String query;
  final List<Movie> results;

  @override
  Widget build(BuildContext context) {
    if (query.trim().isEmpty) {
      return Center(
        child: Text(
          'Search for movies',
          style: context.bodyMedium?.copyWith(color: context.grey600),
        ),
      );
    }

    if (results.isEmpty) {
      return Center(
        child: Text(
          'No results for "$query"',
          style: context.bodyMedium?.copyWith(color: context.grey600),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Search results',
                  style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '${results.length} results',
                style: context.bodySmall?.copyWith(
                  color: context.grey600,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: results.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: context.grey200,
            ),
            itemBuilder: (context, index) => SearchResultTile(
              movie: results[index],
            ),
          ),
        ),
      ],
    );
  }
}
