class AnnouncementRequestModel {
  String filterWhere;
  String filterOrderBy;
  Map<String, dynamic> filterKeyValues;
  int rowPerPage;
  int pageIndex;
  bool isDeleted;

  AnnouncementRequestModel({
    required this.filterWhere,
    required this.filterOrderBy,
    required this.filterKeyValues,
    required this.rowPerPage,
    required this.pageIndex,
    required this.isDeleted,
  });

  Map<String, dynamic> toQueryParameters() {
    return {
      "filter_where": filterWhere,
      "filter_order_by": filterOrderBy,
      "filter_key_values": filterKeyValues,
      "row_per_page": rowPerPage,
      "page_index": pageIndex,
      "is_deleted": isDeleted,
    };
  }
}
