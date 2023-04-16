import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0))),
              isScrollControlled: true,
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      child: Form(
                        key: formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            kHeight15,
                            const Text("Add Contact"),
                            kHeight10,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the name';
                                  }
                                  return null;
                                },
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  labelText: "Enter Name",
                                  focusColor: Colors.black,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).highlightColor),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).highlightColor),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),
                            ),
                            kHeight15,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: phoneController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the phone number';
                                  } else if (!RegExp(r'^[6789]\d{9}$')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid Indian phone number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Enter phone number",
                                  focusColor: Colors.black,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).highlightColor),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).highlightColor),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),
                            ),
                            kHeight10,
                            ElevatedButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  Contact contact = Contact();
                                  contact.addContacts(
                                      name: nameController.text,
                                      number: phoneController.text);
                                } else {
                                  const ScaffoldMessenger(
                                      child: SnackBar(
                                          content:
                                              Text("Please fill the details")));
                                }
                              },
                              child: const Text("Add To Contacts"),
                            ),
                            kHeight15
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.people_alt),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceTint
                            .withOpacity(0.24)),
                  ),
                  kHeight10,
                  StreamBuilder(
                      stream: Contact.getContacts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasData) {
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
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                title: Text(snapshot.data![index].name),
                                subtitle: Text(
                                  snapshot.data![index].number,
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      PopupMenuButton(
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                              child: Text("Edit")),
                                          const PopupMenuItem(
                                              child: Text("Delete")),
                                        ],
                                      );
                                    },
                                    icon: const Icon(Icons.more_vert)),
                              );
                            },
                            separatorBuilder: (context, index) => kHeight5,
                          );
                        } else {
                          return CupertinoActivityIndicator();
                        }
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
