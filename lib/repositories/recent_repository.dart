import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:phone_dialer/models/recent_model.dart';

class Recent {
  static CollectionReference recent =
      FirebaseFirestore.instance.collection("recents");

  static addRecent({
    required String name,
    required String number,
    required String uid,
  }) async {
    DateTime date = DateTime.now();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('recents')
        .where("uid", isEqualTo: uid)
        .get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    if (documents.isEmpty) {
      await recent.doc().set({
        "name": name,
        "number": number,
        "uid": uid,
        "date": date.toString()
      });
    } else {
      QueryDocumentSnapshot documentToDelete = documents.first;
      await documentToDelete.reference.delete();
      Timer(const Duration(seconds: 2), () async {
        log("waited 5 sec");
        await recent.doc().set({
          "name": name,
          "number": number,
          "uid": uid,
          "date": date.toString()
        });
      });
    }
  }

  static Stream<List<RecentModel>> getRecent() {
    return recent.orderBy("date", descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => RecentModel.fromJson(doc)).toList();
    });
  }

  static editContact({
    required String name,
    required String number,
    required String uid,
  }) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('recents')
        .where("uid", isEqualTo: uid)
        .get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    DateTime date = DateTime.now();
    RecentModel recentModel = RecentModel(
        name: name, number: number, uid: uid, date: date.toString());
    recentModel.toJson();
    if (documents.isNotEmpty) {
      QueryDocumentSnapshot documentToDelete = documents.first;
      await documentToDelete.reference
          .update(recentModel.toJson())
          .then((value) => log("added use ${recentModel.toJson()}"))
          .catchError((error) => log("Failed to delete user: $error"));
    }
  }

  static deleteRecentwithContacts({required String uid}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('recents')
        .where("uid", isEqualTo: uid)
        .get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      QueryDocumentSnapshot documentToDelete = documents.first;
      await documentToDelete.reference.delete();
    }
  }
}
