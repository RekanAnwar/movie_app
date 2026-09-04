import 'package:equatable/equatable.dart';

class PaginatedResponse<T> extends Equatable {
  const PaginatedResponse({
    this.data = const [],
    this.page = 0,
    this.totalPages = 0,
    this.totalResults = 0,
  });

  final int page;
  final List<T> data;
  final int totalPages;
  final int totalResults;

  @override
  List<Object?> get props => [data, page, totalPages, totalResults];
}
