class QueryLogResponse {
  final List<QueryLogItem> items;
  final List<Page> pages;

  QueryLogResponse({
    required this.items,
    required this.pages,
  });

  factory QueryLogResponse.fromJson(Map<String, dynamic> json) {
    return QueryLogResponse(
      items: (json['items'] as List?)
          ?.map((e) => QueryLogItem.fromJson(e))
          .toList() ?? [],
      pages: (json['pages'] as List?)
          ?.map((e) => Page.fromJson(e))
          .toList() ?? [],
    );
  }
}

class QueryLogItem {
  final String? companyId;
  final String? categoryType;
  final bool dnssec;
  final String domain;
  final FilteringInfo? filteringInfo;
  final String timeIso;
  final int timeMillis;
  final String? deviceId;
  final String? clientCountry;
  final String? responseCountry;
  final int? asn;
  final String? network;
  final String? dnsRequestType;
  final String? dnsResponseType;

  QueryLogItem({
    this.companyId,
    this.categoryType,
    required this.dnssec,
    required this.domain,
    this.filteringInfo,
    required this.timeIso,
    required this.timeMillis,
    this.deviceId,
    this.clientCountry,
    this.responseCountry,
    this.asn,
    this.network,
    this.dnsRequestType,
    this.dnsResponseType,
  });

  factory QueryLogItem.fromJson(Map<String, dynamic> json) {
    return QueryLogItem(
      companyId: json['company_id'],
      categoryType: json['category_type'],
      dnssec: json['dnssec'],
      domain: json['domain'],
      filteringInfo: json['filtering_info'] != null ? FilteringInfo.fromJson(json['filtering_info']) : null,
      timeIso: json['time_iso'],
      timeMillis: json['time_millis'],
      deviceId: json['device_id'],
      clientCountry: json['client_country'],
      responseCountry: json['response_country'],
      asn: json['asn'],
      network: json['network'],
      dnsRequestType: json['dns_request_type'],
      dnsResponseType: json['dns_response_type'],
    );
  }
}

class FilteringInfo {
  final String filteringStatus; // ENUM
  final String filteringType; // ENUM
  final String? filterId;
  final String? filterRule;
  final String? blockedServiceId;

  FilteringInfo({
    required this.filteringStatus,
    required this.filteringType,
    this.filterId,
    this.filterRule,
    this.blockedServiceId,
  });

  factory FilteringInfo.fromJson(Map<String, dynamic> json) {
    return FilteringInfo(
      filteringStatus: json['filtering_status'],
      filteringType: json['filtering_type'],
      filterId: json['filter_id'],
      filterRule: json['filter_rule'],
      blockedServiceId: json['blocked_service_id'],
    );
  }
}

class Page {
  final bool current;
  final String pageCursor;
  final int pageNumber;

  Page({
    required this.current,
    required this.pageCursor,
    required this.pageNumber,
  });

  factory Page.fromJson(Map<String, dynamic> json) {
    return Page(
      current: json['current'],
      pageCursor: json['page_cursor'],
      pageNumber: json['page_number'],
    );
  }
}
