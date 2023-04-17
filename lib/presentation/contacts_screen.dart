import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_dialer/presentation/widgets/showDialog.dart';
import 'package:phone_dialer/repositories/contact_repository.dart';
import 'package:phone_dialer/utils/sizes.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    TextEditingController nameEditController = TextEditingController();
    TextEditingController phoneEditController = TextEditingController();
    GlobalKey<FormState> editformkey = GlobalKey<FormState>();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AddContactBottomSheet(
                context, formkey, nameController, phoneController);
            nameController.clear();
            phoneController.clear();
          },
          child: const Icon(Icons.people_alt),
        ),
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
                          "Contacts",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox.shrink()
                      ],
                    ),
                  ),
                  kHeight10,
                  StreamBuilder(
                      stream: Contact.getContacts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          if (snapshot.data!.isEmpty) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 300.h,
                                ),
                                const Text(
                                  "Please Add Contacts",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            );
                          } else {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.yellow,
                                    radius: 20,
                                    child: Text(
                                      snapshot.data![index].name[0],
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  title: GestureDetector(
                                      onTap: () async {
                                        Contact contact = Contact();
                                        try {
                                          await FlutterPhoneDirectCaller
                                              .callNumber(
                                                  snapshot.data![index].number);
                                          Contact.editContact(
                                            name: snapshot.data![index].name,
                                            number:
                                                snapshot.data![index].number,
                                            docId: snapshot.data![index].did
                                                .toString(),
                                            recent:
                                                snapshot.data![index].recent++,
                                          );
                                        } catch (e) {
                                          // handle the error
                                          log(e.toString());
                                        }
                                      },
                                      child: Text(snapshot.data![index].name)),
                                  subtitle: Text(
                                    snapshot.data![index].number.toString(),
                                  ),
                                  trailing: PopupMenuButton(
                                    itemBuilder: (BuildContext context) => [
                                      const PopupMenuItem(
                                        value: 'menu_1',
                                        child: Text('Edit'),
                                      ),
                                      const PopupMenuItem(
                                        value: 'menu_2',
                                        child: Text('Delete'),
                                      ),
                                    ],
                                    onSelected: (String value) async {
                                      if (value == "menu_2") {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text("Delete Contact"),
                                              content: const Text(
                                                  "Are you sure you want to delete the contact"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text("Cancel")),
                                                TextButton(
                                                    onPressed: () async {
                                                      await Contact
                                                          .deleteContact(
                                                              docId: snapshot
                                                                  .data![index]
                                                                  .did
                                                                  .toString());
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Delete"))
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        EditContactBottomSheet(
                                          context,
                                          editformkey,
                                          nameEditController,
                                          phoneEditController,
                                          snapshot.data![index].name,
                                          snapshot.data![index].number,
                                          snapshot.data![index].did.toString(),
                                          snapshot.data![index].recent,
                                        );
                                      }
                                    },
                                  ),
                                );
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
          ),
        ));
  }
}
