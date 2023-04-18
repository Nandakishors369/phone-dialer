import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_dialer/repositories/contact_repository.dart';
import 'package:phone_dialer/repositories/recent_repository.dart';
import 'package:phone_dialer/utils/sizes.dart';

Future<dynamic> EditContactBottomSheet(
    BuildContext context,
    GlobalKey<FormState> editformkey,
    TextEditingController nameEditController,
    TextEditingController phoneEditController,
    String exname,
    String exnumber,
    String docId,
    int recent) {
  nameEditController.text = exname;
  phoneEditController.text = exnumber;
  return showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    isScrollControlled: true,
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Form(
              key: editformkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  kHeight15,
                  const Text("Edit Contact"),
                  kHeight10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the name';
                        }
                        return null;
                      },
                      controller: nameEditController,
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Enter Name",
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).highlightColor),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).highlightColor),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                  kHeight15,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: phoneEditController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the phone number';
                        } else if (!RegExp(r'^[6789]\d{9}$').hasMatch(value)) {
                          return 'Please enter a valid Indian phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter phone number",
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).highlightColor),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).highlightColor),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                  kHeight10,
                  ElevatedButton(
                    onPressed: () async {
                      if (editformkey.currentState!.validate()) {
                        await Contact.editContact(
                            name: nameEditController.text,
                            number: phoneEditController.text,
                            docId: docId,
                            recent: recent);
                        await Recent.editContact(
                            name: nameEditController.text,
                            number: phoneEditController.text,
                            uid: docId);
                        Navigator.pop(context);
                        nameEditController.clear();
                        phoneEditController.clear();
                      } else {
                        const ScaffoldMessenger(
                            child: SnackBar(
                                content: Text("Please fill the details")));
                      }
                    },
                    child: const Text("Edit Contacts"),
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
}

Future<dynamic> AddContactBottomSheet(
    BuildContext context,
    GlobalKey<FormState> formkey,
    TextEditingController nameController,
    TextEditingController phoneController) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    isScrollControlled: true,
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the name';
                        }
                        return null;
                      },
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Enter Name",
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).highlightColor),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).highlightColor),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                  kHeight15,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: phoneController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the phone number';
                        } else if (!RegExp(r'^[6789]\d{9}$').hasMatch(value)) {
                          return 'Please enter a valid Indian phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter phone number",
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).highlightColor),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).highlightColor),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                  kHeight10,
                  ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        Contact contact = Contact();
                        contact.addContacts(
                            name: nameController.text,
                            number: phoneController.text);
                        Navigator.pop(context);
                        nameController.clear();
                        phoneController.clear();
                      } else {
                        const ScaffoldMessenger(
                            child: SnackBar(
                                content: Text("Please fill the details")));
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
}
