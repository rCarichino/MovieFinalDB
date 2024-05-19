class ProfileDetailsParams {
  ProfileDetailsParams({
    this.userName,
    this.photoUrl,
    this.phoneNumber,
  });

  ProfileDetailsParams.fromJson(dynamic json) {
    userName = json['userName'];
    photoUrl = json['photoUrl'];
    phoneNumber = json['phoneNumber'];
  }

  String? userName;
  String? photoUrl;
  String? phoneNumber;

  ProfileDetailsParams copyWith({
    String? userName,
    String? photoUrl,
    String? phoneNumber,
  }) =>
      ProfileDetailsParams(
        userName: userName ?? this.userName,
        photoUrl: photoUrl ?? this.photoUrl,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = userName;
    map['photoUrl'] = photoUrl;
    map['phoneNumber'] = phoneNumber;
    return map;
  }
}
