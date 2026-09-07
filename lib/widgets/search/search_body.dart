import 'dart:async';

import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/gen/gen.dart';
import 'package:movie_app/providers/providers.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/empty_state.dart';
import 'package:movie_app/widgets/error_state.dart';
import 'package:movie_app/widgets/search/search_movie_tile.dart';
import 'package:movie_app/widgets/wave_shimmer.dart';

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

    final Widget child;

    if (trimmedQuery.isEmpty) {
      child = EmptyState(
        key: const ValueKey('empty-search'),
        image: Assets.images.emptySearch,
        title: 'Search for movies',
        description: 'Find titles by name and browse matching results.',
      );
    } else if (debouncedQuery.value != trimmedQuery) {
      child = const _SearchBodyShimmer(
        key: ValueKey('search-debounce-shimmer'),
      );
    } else {
      final firstPageFuture = ref.watch(
        searchMoviesFutureProvider(
          SearchMoviesFutureProviderParams(
            query: debouncedQuery.value,
          ),
        ),
      );

      child = firstPageFuture.when(
        data: (firstPage) {
          final totalResults = firstPage.totalResults;

          if (totalResults == 0) {
            return EmptyState(
              key: ValueKey('empty-search-result-$trimmedQuery'),
              image: Assets.images.emptySearchResult,
              title: 'No results for "$trimmedQuery"',
              description: 'Try different keywords or check your spelling.',
            );
          }

          return _SearchResults(
            key: ValueKey('search-results-${debouncedQuery.value}'),
            query: debouncedQuery.value,
            totalResults: totalResults,
          );
        },
        error: (error, stackTrace) => ErrorState(
          key: ValueKey('search-error-${debouncedQuery.value}'),
          error: error,
          onRetry: () => ref.invalidate(
            searchMoviesFutureProvider(
              SearchMoviesFutureProviderParams(
                query: debouncedQuery.value,
              ),
            ),
          ),
        ),
        loading: () => const _SearchBodyShimmer(
          key: ValueKey('search-loading-shimmer'),
        ),
      );
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) =>
          ref.invalidate(searchMoviesFutureProvider),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        layoutBuilder: (currentChild, previousChildren) => Stack(
          children: [
            ...previousChildren,
            ?currentChild,
          ],
        ),
        child: child,
      ),
    );
  }
}

class _SearchResults extends ConsumerWidget {
  const _SearchResults({
    super.key,
    required this.query,
    required this.totalResults,
  });

  final String query;
  final int totalResults;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        SliverList.builder(
          itemCount: totalResults,
          itemBuilder: (context, index) {
            final page = index ~/ moviesPageSize + 1;
            final indexInPage = index % moviesPageSize;

            final pageFuture = ref.watch(
              searchMoviesFutureProvider(
                SearchMoviesFutureProviderParams(
                  query: query,
                  page: page,
                ),
              ),
            );

            return pageFuture.when(
              data: (pageResponse) {
                if (indexInPage >= pageResponse.data.length) {
                  return const SizedBox.shrink();
                }

                return Column(
                  children: [
                    SearchMovieTile(
                      movie: pageResponse.data[indexInPage],
                    ),
                    if (indexInPage < totalResults - 1)
                      Divider(height: 1, color: context.grey200),
                  ],
                );
              },
              error: (error, stackTrace) => const SizedBox.shrink(),
              loading: () => Column(
                children: [
                  const SearchMovieTileShimmer(),
                  if (indexInPage < totalResults - 1)
                    Divider(height: 1, color: context.grey200),
                ],
              ),
            );
          },
        ),
        SizedBox(height: context.paddingBottom + 16).toSliver,
      ],
    );
  }
}

class _SearchBodyShimmer extends StatelessWidget {
  const _SearchBodyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const WaveShimmer(
                width: 140,
                height: 20,
                radius: 4,
              ),
              WaveShimmer(
                width: 72,
                height: 16,
                radius: 4,
                baseColor: context.grey50,
              ),
            ],
          ),
        ).toSliver,
        SliverList.separated(
          itemCount: 6,
          separatorBuilder: (context, index) =>
              Divider(height: 1, color: context.grey200),
          itemBuilder: (context, index) => const SearchMovieTileShimmer(),
        ),
      ],
    );
  }
}
