class SearchParams{
  SearchParams({
      this.query, 
      this.year,
  this.page});

  SearchParams.fromJson(dynamic json) {
    query = json['query'];
    year = json['year'];
    page = json["page"];
  }
  String? query;
  String? year;
  int? page;
  SearchParams copyWith({  String? query,
  String? year, int? page
}) => SearchParams(  query: query ?? this.query,
  year: year ?? this.year, page: page ?? this.page
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['query'] = query;
    map['year'] = year;
    map["page"] = page;
    return map;
  }

}