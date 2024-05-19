class ResetParams {
  ResetParams({
    this.newEmail,
    this.password,
    this.newPassword,
  });

  ResetParams.fromJson(dynamic json) {
    newEmail = json['newEmail'];
    password = json['password'];
    newPassword = json['newPassword'];
  }

  String? newEmail;
  String? password;
  String? newPassword;

  ResetParams copyWith({
    String? newEmail,
    String? password,
    String? newPassword,
  }) =>
      ResetParams(
        newEmail: newEmail ?? this.newEmail,
        password: password ?? this.password,
        newPassword: newPassword ?? this.newPassword,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['newEmail'] = newEmail;
    map['password'] = password;
    map['newPassword'] = newPassword;
    return map;
  }
}
