import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:movie_app/widgets/search/search.dart';

class SearchPage extends SearchDelegate<Movie?> {
  SearchPage()
    : super(
        searchFieldLabel: 'Search movies...',
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
      );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return context.theme.copyWith(
      appBarTheme: context.appBarTheme.copyWith(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: context.surface,
        foregroundColor: context.onSurface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: context.surfaceContainer,
        hintStyle: context.bodyMedium?.copyWith(
          color: context.onSurface.withValues(alpha: 0.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.primaryContainer),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        onPressed: query.isEmpty ? null : () => query = '',
        icon: Icon(
          Icons.close_rounded,
          color: query.isEmpty ? context.grey200 : context.grey700,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back_rounded, color: context.onSurface),
    );
  }

  @override
  Widget buildResults(BuildContext context) => SearchBody(query: query);

  @override
  Widget buildSuggestions(BuildContext context) => SearchBody(query: query);
}
