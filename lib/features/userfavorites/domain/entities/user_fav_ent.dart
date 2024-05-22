class UserFavEnt {
  UserFavEnt({
    this.movieName,
    this.movieId,
    this.userIds,
  });

  UserFavEnt.fromJson(dynamic json) {
    movieName = json['movieName'];
    movieId = json['movieId'];
    userIds = json['userIds'] != null ? json['userIds'].cast<String>() : [];
  }

  String? movieName;
  String? movieId;
  List<String>? userIds;

  UserFavEnt copyWith({
    String? movieName,
    String? movieId,
    List<String>? userIds,
  }) =>
      UserFavEnt(
        movieName: movieName ?? this.movieName,
        movieId: movieId ?? this.movieId,
        userIds: userIds ?? this.userIds,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movieName'] = movieName;
    map['movieId'] = movieId;
    map['userIds'] = userIds;
    return map;
  }
}
