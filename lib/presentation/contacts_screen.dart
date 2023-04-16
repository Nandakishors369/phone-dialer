import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_dialer/presentation/widgets/showDialog.dart';
import 'package:phone_dialer/utils/sizes.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 300.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Add Contact"),
                        TextFormField(
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).highlightColor,
                                      width: 3))),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).highlightColor,
                                      width: 3))),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: Text("Add To Contacts"))
                      ],
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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.yellow,
                          radius: 20,
                        ),
                        title: Text("name"),
                        subtitle: Text("mobilee"),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert)),
                      );
                    },
                    separatorBuilder: (context, index) => kHeight5,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
