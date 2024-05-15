class RegisterResponse {
  RegisterResponse({
    this.email,
    this.password,
  });

  RegisterResponse.fromJson(dynamic json) {
    email = json['username'];
    password = json['password'];
  }

  String? email;
  String? password;

  RegisterResponse copyWith({
    String? email,
    String? password,
  }) =>
      RegisterResponse(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = email;
    map['password'] = password;
    return map;
  }
}
