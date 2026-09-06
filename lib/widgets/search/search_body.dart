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

    final firstPageFuture = ref.watch(
      searchMoviesFutureProvider(
        SearchMoviesFutureProviderParams(
          query: debouncedQuery.value,
        ),
      ),
    );

    return firstPageFuture.when(
      data: (firstPage) {
        final totalResults = firstPage.totalResults;

        if (totalResults == 0) {
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
                    '$totalResults results',
                    style: context.bodySmall?.copyWith(
                      color: context.grey600,
                    ),
                  ),
                ],
              ),
            ).toSliver,
            SliverList.separated(
              itemCount: totalResults,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: context.grey200),
              itemBuilder: (context, index) {
                final page = index ~/ moviesPageSize + 1;
                final indexInPage = index % moviesPageSize;

                final pageFuture = ref.watch(
                  searchMoviesFutureProvider(
                    SearchMoviesFutureProviderParams(
                      query: debouncedQuery.value,
                      page: page,
                    ),
                  ),
                );

                return pageFuture.when(
                  data: (pageResponse) {
                    if (indexInPage >= pageResponse.data.length) {
                      return const SizedBox.shrink();
                    }

                    return SearchResultTile(
                      movie: pageResponse.data[indexInPage],
                    );
                  },
                  error: (error, stackTrace) => indexInPage == 0
                      ? _SearchPageError(
                          onRetry: () => ref.invalidate(
                            searchMoviesFutureProvider(
                              SearchMoviesFutureProviderParams(
                                page: page,
                                query: debouncedQuery.value,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  loading: () => SizedBox(
                    height: 124,
                    child: indexInPage == 0
                        ? const Center(child: CircularProgressIndicator())
                        : null,
                  ),
                );
              },
            ),
            SizedBox(height: context.paddingBottom + 16).toSliver,
          ],
        );
      },
      error: (error, stackTrace) => Center(
        child: _SearchPageError(
          onRetry: () => ref.invalidate(
            searchMoviesFutureProvider(
              SearchMoviesFutureProviderParams(
                query: debouncedQuery.value,
              ),
            ),
          ),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _SearchPageError extends StatelessWidget {
  const _SearchPageError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Something went wrong',
            style: context.bodyMedium?.copyWith(color: context.grey600),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(
              foregroundColor: context.primaryContainer,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
