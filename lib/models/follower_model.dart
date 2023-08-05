// To parse this JSON data, do
//
//     final followerModel = followerModelFromJson(jsonString);

import 'dart:convert';

FollowerModel followerModelFromJson(String str) => FollowerModel.fromJson(json.decode(str));

String followerModelToJson(FollowerModel data) => json.encode(data.toJson());

class FollowerModel {
  int? followingCount;
  int? followersCount;
  List<dynamic>? following;
  List<dynamic>? followers;

  FollowerModel({
    this.followingCount,
    this.followersCount,
    this.following,
    this.followers,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) => FollowerModel(
    followingCount: json["following_count"],
    followersCount: json["followers_count"],
    following: json["following"] == null ? [] : List<dynamic>.from(json["following"]!.map((x) => x)),
    followers: json["followers"] == null ? [] : List<dynamic>.from(json["followers"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "following_count": followingCount,
    "followers_count": followersCount,
    "following": following == null ? [] : List<dynamic>.from(following!.map((x) => x)),
    "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x)),
  };
}
