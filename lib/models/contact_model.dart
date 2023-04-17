// To parse this JSON data, do
//
//     final contactModel = contactModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ContactModel contactModelFromJson(String str, String did) =>
    ContactModel.fromJson(json.decode(str), did);

String contactModelToJson(ContactModel data) => json.encode(data.toJson());

class ContactModel {
  ContactModel(
      {required this.name,
      required this.number,
      required this.recent,
      this.did});

  String name;
  String number;
  int recent;
  String? did;

  factory ContactModel.fromJson(DocumentSnapshot json, String did) =>
      ContactModel(
          name: json["name"],
          number: json["number"],
          recent: json["recent"],
          did: did);

  Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "recent": recent,
      };
}
