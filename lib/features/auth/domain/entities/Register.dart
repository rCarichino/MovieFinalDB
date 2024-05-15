class Register {
  Register({
      this.email, 
      this.password,});

  Register.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
  }
  String? email;
  String? password;
Register copyWith({  String? email,
  String? password,
}) => Register(  email: email ?? this.email,
  password: password ?? this.password,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }

}