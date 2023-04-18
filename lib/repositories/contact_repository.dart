import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_dialer/models/contact_model.dart';

class Contact {
  static CollectionReference contacts =
      FirebaseFirestore.instance.collection('contacts');

  addContacts({required String name, required String number}) async {
    ContactModel contactModel =
        ContactModel(name: name, number: number, recent: 0);
    contactModel.toJson();
    await contacts
        .add(contactModel.toJson())
        .then((value) => log("added ${contactModel.toJson()}"))
        .catchError((error) => log("failed $error"));

    // contacts.add(data)
  }

  static Stream<List<ContactModel>> getContacts() {
    return contacts.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ContactModel.fromJson(doc, doc.id))
          .toList();
    });
  }

  static deleteContact({required String docId}) async {
    await contacts
        .doc(docId)
        .delete()
        .then((value) => log("User Deleted"))
        .catchError((error) => log("Failed to delete user: $error"));
  }

  static editContact(
      {required String name,
      required String number,
      required String docId,
      required int recent}) async {
    ContactModel contactModel =
        ContactModel(name: name, number: number, recent: recent);
    contactModel.toJson();
    await contacts
        .doc(docId)
        .update(contactModel.toJson())
        .then((value) => log("added use ${contactModel.toJson()}"))
        .catchError((error) => log("Failed to delete user: $error"));
  }

  static Future<QuerySnapshot> searchUsers(String query) {
    return contacts
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .get();
  }
}
