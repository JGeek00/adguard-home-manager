class FilterList {
  final String filterId;
  final String name;
  final String description;
  final String homepageUrl;
  final String sourceUrl;
  final String downloadUrl;
  final int rulesCount;
  final DateTime timeUpdated;
  final List<String> tags;
  final List<FilterListCategory> categories;

  FilterList({
    required this.filterId,
    required this.name,
    required this.description,
    required this.homepageUrl,
    required this.sourceUrl,
    required this.downloadUrl,
    required this.rulesCount,
    required this.timeUpdated,
    required this.tags,
    required this.categories,
  });

  factory FilterList.fromJson(Map<String, dynamic> json) {
    return FilterList(
      filterId: json['filter_id'],
      name: json['name'],
      description: json['description'] ?? '',
      homepageUrl: json['homepage_url'],
      sourceUrl: json['source_url'],
      downloadUrl: json['download_url'],
      rulesCount: json['rules_count'],
      timeUpdated: DateTime.parse(json['time_updated']),
      tags: List<String>.from(json['tags'] ?? []),
      categories: (json['categories'] as List?)
          ?.map((e) => FilterListCategory.fromJson(e))
          .toList() ?? [],
    );
  }
}

class FilterListCategory {
  final String category; // ENUM: GENERAL, SECURITY, REGIONAL, OTHER
  final String description;
  final String? value;

  FilterListCategory({
    required this.category,
    required this.description,
    this.value,
  });

  factory FilterListCategory.fromJson(Map<String, dynamic> json) {
    return FilterListCategory(
      category: json['category'],
      description: json['description'],
      value: json['value'],
    );
  }
}
