class Login {
  Login({
    this.uid,
    this.token,
  });

  Login.fromJson(dynamic json) {
    uid = json['Username'];
    token = json['Token'];
  }

  String? uid;
  String? token;

  Login copyWith({
    String? uid,
    String? token,
  }) =>
      Login(
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
