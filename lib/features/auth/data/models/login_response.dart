class LoginResponse {
  LoginResponse({
    this.uid,
    this.token,
  });

  LoginResponse.fromJson(dynamic json) {
    uid = json['Username'];
    token = json['Token'];
  }

  String? uid;
  String? token;

  LoginResponse copyWith({
    String? uid,
    String? token,
  }) =>
      LoginResponse(
        uid: uid ?? this.uid,
        token: token ?? this.token,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['Token'] = token;
    return map;
  }
}
