import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:phone_dialer/models/contact_model.dart';
import 'package:phone_dialer/repositories/contact_repository.dart';
import 'package:phone_dialer/repositories/recent_repository.dart';
import 'package:phone_dialer/utils/sizes.dart';

class SearchContact extends SearchDelegate {
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      stream: Contact.getContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No contacts found",
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            List<ContactModel> data = [];
            for (var element in snapshot.data!) {
              if (element.name.toLowerCase().contains(query.toLowerCase()) ||
                  element.number.contains(query)) {
                data.add(element);
              }
            }

            log(snapshot.data.toString());

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 20,
                  ),
                  title: Text(data[index].name),
                  subtitle: Text(data[index].number),
                );
              },
              separatorBuilder: (context, index) => kHeight5,
            );
          }
        } else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text(
        "Search you contacts here",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }
}
