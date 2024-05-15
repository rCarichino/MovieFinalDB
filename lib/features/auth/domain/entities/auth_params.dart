class AuthParams {
  AuthParams({
    this.email,
    this.password,
  });

  AuthParams.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
  }

  String? email;
  String? password;

  AuthParams copyWith({
    String? email,
    String? password,
  }) =>
      AuthParams(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}
