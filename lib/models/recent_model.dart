// To parse this JSON data, do
//
//     final recentModel = recentModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

RecentModel recentModelFromJson(String str) =>
    RecentModel.fromJson(json.decode(str));

String recentModelToJson(RecentModel data) => json.encode(data.toJson());

class RecentModel {
  RecentModel(
      {required this.name,
      required this.number,
      required this.uid,
      required this.date});

  String name;
  String number;
  String date;
  String uid;

  factory RecentModel.fromJson(DocumentSnapshot json) => RecentModel(
      name: json["name"],
      number: json["number"],
      uid: json['uid'],
      date: json['date']);

  Map<String, dynamic> toJson() =>
      {"name": name, "number": number, "uid": uid, "date": date};
}
