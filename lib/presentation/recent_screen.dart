import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';
import 'package:phone_dialer/models/contact_model.dart';
import 'package:phone_dialer/models/recent_model.dart';
import 'package:phone_dialer/repositories/contact_repository.dart';
import 'package:phone_dialer/repositories/recent_repository.dart';
import 'package:phone_dialer/utils/sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Recents",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox.shrink()
                  ],
                ),
              ),
              kHeight10,
              StreamBuilder(
                  stream: Recent.getRecent(),
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
                        List<RecentModel> data = [];
                        snapshot.data!.reversed.forEach((element) {
                          data.add(element);
                        });

                        log(snapshot.data.toString());

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime =
                                DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS")
                                    .parse(snapshot.data![index].date);

// Format DateTime object to "dd-mm hh:mm AM/PM" format
                            String formattedDateString =
                                DateFormat("h:mm a dd MMM").format(dateTime);

                            return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.yellow,
                                  child: Text(
                                    snapshot.data![index].name[0].toUpperCase(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  radius: 20,
                                ),
                                title: Text(snapshot.data![index].name),
                                subtitle: Text(snapshot.data![index].number),
                                trailing: SizedBox(
                                    width: 70,
                                    child: Text(formattedDateString)));
                          },
                          separatorBuilder: (context, index) => kHeight5,
                        );
                      }
                    } else {
                      return const CupertinoActivityIndicator();
                    }
                  })
            ],
          ),
        ),
      )),
    );
  }

  void sortListDescending(List<ContactModel> list, String key) {
    list.sort((a, b) => b.toJson()[key].compareTo(a.toJson()[key]));
  }
}
