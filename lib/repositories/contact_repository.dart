import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_dialer/models/contact_model.dart';

class Contact {
  CollectionReference contacts =
      FirebaseFirestore.instance.collection('contacts');

  addContacts({required String name, required String number}) async {
    ContactModel contactModel = ContactModel(name: name, number: number);
    contactModel.toJson();
    await contacts
        .add(contactModel.toJson())
        .then((value) => log("added $contactModel"))
        .catchError((error) => log("failed $error"));

    // contacts.add(data)
  }
}
