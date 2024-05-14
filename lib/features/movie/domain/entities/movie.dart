class Movie {
  Movie({
      this.adult, 
      this.genreIds, 
      this.id, 
      this.originalLanguage, 
      this.originalTitle, 
      this.overview, 
      this.posterPath, 
      this.releaseDate, 
      this.title, 
      this.video,});

  Movie.fromJson(dynamic json) {
    adult = json['adult'];
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
  }
  bool? adult;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  dynamic posterPath;
  String? releaseDate;
  String? title;
  bool? video;
Movie copyWith({  bool? adult,
  List<int>? genreIds,
  int? id,
  String? originalLanguage,
  String? originalTitle,
  String? overview,
  dynamic posterPath,
  String? releaseDate,
  String? title,
  bool? video,
}) => Movie(  adult: adult ?? this.adult,
  genreIds: genreIds ?? this.genreIds,
  id: id ?? this.id,
  originalLanguage: originalLanguage ?? this.originalLanguage,
  originalTitle: originalTitle ?? this.originalTitle,
  overview: overview ?? this.overview,
  posterPath: posterPath ?? this.posterPath,
  releaseDate: releaseDate ?? this.releaseDate,
  title: title ?? this.title,
  video: video ?? this.video,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['genre_ids'] = genreIds;
    map['id'] = id;
    map['original_language'] = originalLanguage;
    map['original_title'] = originalTitle;
    map['overview'] = overview;
    map['poster_path'] = posterPath;
    map['release_date'] = releaseDate;
    map['title'] = title;
    map['video'] = video;
    return map;
  }

}