import 'dart:async';

import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/search/search_result_tile.dart';

class SearchBody extends HookConsumerWidget {
  const SearchBody({
    super.key,
    required this.query,
  });

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trimmedQuery = query.trim();
    final debouncedQuery = useState(trimmedQuery);

    useEffect(
      () {
        final timer = Timer(
          const Duration(milliseconds: 400),
          () => debouncedQuery.value = trimmedQuery,
        );

        return timer.cancel;
      },
      [trimmedQuery],
    );

    if (trimmedQuery.isEmpty) {
      return Center(
        child: Text(
          'Search for movies',
          style: context.bodyMedium?.copyWith(color: context.grey600),
        ),
      );
    }

    if (debouncedQuery.value != trimmedQuery) {
      return const Center(child: CircularProgressIndicator());
    }

    final searchFuture = ref.watch(
      searchMoviesFutureProvider(debouncedQuery.value),
    );

    return searchFuture.when(
      data: (paginatedResponse) {
        final results = paginatedResponse.data;

        if (results.isEmpty) {
          return Center(
            child: Text(
              'No results for "$trimmedQuery"',
              style: context.bodyMedium?.copyWith(color: context.grey600),
            ),
          );
        }

        return CustomScrollView(
          slivers: [
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
                    '${paginatedResponse.totalResults} results',
                    style: context.bodySmall?.copyWith(
                      color: context.grey600,
                    ),
                  ),
                ],
              ),
            ).toSliver,
            SliverList.separated(
              itemCount: results.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: context.grey200,
              ),
              itemBuilder: (context, index) => SearchResultTile(
                movie: results[index],
              ),
            ),
            SizedBox(height: context.paddingBottom + 16).toSliver,
          ],
        );
      },
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
