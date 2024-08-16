import 'dart:convert';

class User {
  String name;
  String email;
  User({required this.name, required this.email});
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
    };
  }

  String toJson() => json.encode(toMap());
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map["name"],
      email: map["email"],
    );
  }
  factory User.fromJson(String value) {
    return User.fromMap(json.decode(value));
  }
}
