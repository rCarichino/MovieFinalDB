class LoginResponse {
  LoginResponse({
    this.username,
    this.password,
    this.token,
  });

  LoginResponse.fromJson(dynamic json) {
    username = json['Username'];
    password = json['Password'];
    token = json['Token'];
  }

  String? username;
  String? password;
  String? token;

  LoginResponse copyWith({
    String? username,
    String? password,
    String? token,
  }) =>
      LoginResponse(
        username: username ?? this.username,
        password: password ?? this.password,
        token: token ?? this.token,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Username'] = username;
    map['Password'] = password;
    map['Token'] = token;
    return map;
  }
}
