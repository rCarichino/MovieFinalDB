class RegisterResponse {
  RegisterResponse({
    this.username,
    this.password,
  });

  RegisterResponse.fromJson(dynamic json) {
    username = json['username'];
    password = json['password'];
  }

  String? username;
  String? password;

  RegisterResponse copyWith({
    String? username,
    String? password,
  }) =>
      RegisterResponse(
        username: username ?? this.username,
        password: password ?? this.password,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    return map;
  }
}
