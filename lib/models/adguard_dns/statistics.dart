class Statistics {
  // Generic class for various statistics lists, or we can make specific ones.
  // The API returns distinct lists: CategoryQueriesStatsList, CompanyQueriesStatsList, etc.
  // I'll make a generic wrapper or individual classes as needed.
}

class QueriesStats {
  final int blocked;
  final int companies;
  final int queries;

  QueriesStats({
    required this.blocked,
    required this.companies,
    required this.queries,
  });

  factory QueriesStats.fromJson(Map<String, dynamic> json) {
    return QueriesStats(
      blocked: json['blocked'],
      companies: json['companies'],
      queries: json['queries'],
    );
  }
}

class CategoryQueriesStats {
  final String categoryType;
  final int queries;

  CategoryQueriesStats({
    required this.categoryType,
    required this.queries,
  });

  factory CategoryQueriesStats.fromJson(Map<String, dynamic> json) {
    return CategoryQueriesStats(
      categoryType: json['category_type'],
      queries: json['queries'],
    );
  }
}

class CategoryQueriesStatsList {
  final List<CategoryQueriesStats> stats;

  CategoryQueriesStatsList({required this.stats});

  factory CategoryQueriesStatsList.fromJson(Map<String, dynamic> json) {
    return CategoryQueriesStatsList(
      stats: (json['stats'] as List).map((e) => CategoryQueriesStats.fromJson(e)).toList(),
    );
  }
}
