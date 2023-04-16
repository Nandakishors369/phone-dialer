import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_dialer/models/contact_model.dart';
import 'package:phone_dialer/presentation/contacts_screen.dart';

class Contact {
  static CollectionReference contacts =
      FirebaseFirestore.instance.collection('contacts');

  addContacts({required String name, required String number}) async {
    ContactModel contactModel = ContactModel(name: name, number: "+91$number");
    contactModel.toJson();
    await contacts
        .add(contactModel.toJson())
        .then((value) => log("added ${contactModel.toJson()}"))
        .catchError((error) => log("failed $error"));

    // contacts.add(data)
  }

  static Stream<List<ContactModel>> getContacts() {
    return contacts.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ContactModel.fromJson(doc)).toList();
    });
  }
}
