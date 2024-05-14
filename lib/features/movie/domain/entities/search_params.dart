class SearchParams{
  SearchParams({
      this.query, 
      this.year,});

  SearchParams.fromJson(dynamic json) {
    query = json['query'];
    year = json['year'];
  }
  String? query;
  String? year;
  SearchParams copyWith({  String? query,
  String? year,
}) => SearchParams(  query: query ?? this.query,
  year: year ?? this.year,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['query'] = query;
    map['year'] = year;
    return map;
  }

}