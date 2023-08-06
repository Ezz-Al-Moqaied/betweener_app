// To parse this JSON data, do
//
//     final registerUser = registerUserFromJson(jsonString);

import 'dart:convert';

RegisterUser registerUserFromJson(String str) => RegisterUser.fromJson(json.decode(str));

String registerUserToJson(RegisterUser data) => json.encode(data.toJson());

class RegisterUser {
  String? message;
  User? user;
  String? token;

  RegisterUser({
    this.message,
    this.user,
    this.token,
  });

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user?.toJson(),
    "token": token,
  };
}

class User {
  String? name;
  String? email;
  String? updatedAt;
  String? createdAt;
  int? id;

  User({
    this.name,
    this.email,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}
