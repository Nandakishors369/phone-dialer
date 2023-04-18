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
    // Called when the user taps the back button on the search bar
    // Return a widget that will go back to the previous screen
    return IconButton(
      icon: Icon(Icons.arrow_back),
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
            return const Text(
              "Please Add Contacts",
              style: TextStyle(color: Colors.white),
            );
          } else {
            List<ContactModel> data = [];
            snapshot.data!.forEach((element) {
              if (element.name.toLowerCase().contains(query.toLowerCase()) ||
                  element.number.contains(query)) {
                data.add(element);
              }
            });

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
                  trailing: IconButton(
                      onPressed: () async {
                        Contact contact = Contact();
                        try {
                          await FlutterPhoneDirectCaller.callNumber(
                              snapshot.data![index].number);

                          Recent.addRecent(
                              name: snapshot.data![index].name,
                              number: snapshot.data![index].number,
                              uid: snapshot.data![index].did.toString());
                        } catch (e) {
                          // handle the error
                          log(e.toString());
                        }
                      },
                      icon: const Icon(Icons.call)),
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
    return Container();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // Called when the user taps the search icon or clears the search bar
    // Return a list of widgets that will perform actions on the search bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }
}
