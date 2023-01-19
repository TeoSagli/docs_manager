class UserCredsModel {
  String password;
  String email;

  UserCredsModel(
    this.email,
    this.password,
  );

  UserCredsModel.fromJson(Map<String, dynamic> json)
      : password = json['password'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'password': password,
        'email': email,
      };
  setEmail(e) {
    email = e;
  }

  setPassword(p) {
    password = p;
  }
}
