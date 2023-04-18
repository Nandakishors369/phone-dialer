import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phone_dialer/models/recent_model.dart';
import 'package:phone_dialer/repositories/recent_repository.dart';
import 'package:phone_dialer/utils/sizes.dart';

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
                        return Column(
                          children: [
                            SizedBox(
                              height: 300.h,
                            ),
                            const Text(
                              "Please make a call to see recents",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        );
                      } else {
                        List<RecentModel> data = [];
                        for (var element in snapshot.data!.reversed) {
                          data.add(element);
                        }

                        log(snapshot.data.toString());

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime =
                                DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS")
                                    .parse(snapshot.data![index].date);

                            String formattedDateString =
                                DateFormat("h:mm a dd MMM").format(dateTime);

                            return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.yellow,
                                  radius: 20,
                                  child: Text(
                                    snapshot.data![index].name[0].toUpperCase(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
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
                      return Column(
                        children: [
                          SizedBox(
                            height: 300.h,
                          ),
                          const Text(
                            "Something went wrong",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      );
                    }
                  })
            ],
          ),
        ),
      )),
    );
  }
}
