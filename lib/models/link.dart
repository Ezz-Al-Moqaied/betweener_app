// To parse this JSON data, do
//
//     final linkModel = linkModelFromJson(jsonString);

import 'dart:convert';

LinkModel linkModelFromJson(String str) => LinkModel.fromJson(json.decode(str));

String linkModelToJson(LinkModel data) => json.encode(data.toJson());

class LinkModel {
  Link? link;

  LinkModel({
    this.link,
  });

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
    link: json["link"] == null ? null : Link.fromJson(json["link"]),
  );

  Map<String, dynamic> toJson() => {
    "link": link?.toJson(),
  };
}

class Link {
  int? id;
  String? title;
  String? link;
  dynamic username;
  int? isActive;
  int? userId;
  String? createdAt;
  String? updatedAt;
  User? user;

  Link({
    this.id,
    this.title,
    this.link,
    this.username,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    id: json["id"],
    title: json["title"],
    link: json["link"],
    username: json["username"],
    isActive: json["isActive"],
    userId: json["user_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "link": link,
    "username": username,
    "isActive": isActive,
    "user_id": userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? isActive;
  dynamic country;
  dynamic ip;
  dynamic long;
  dynamic lat;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.country,
    this.ip,
    this.long,
    this.lat,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    isActive: json["isActive"],
    country: json["country"],
    ip: json["ip"],
    long: json["long"],
    lat: json["lat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "isActive": isActive,
    "country": country,
    "ip": ip,
    "long": long,
    "lat": lat,
  };
}
