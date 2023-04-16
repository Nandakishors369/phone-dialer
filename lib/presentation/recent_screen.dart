import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
                    subtitle: Text("time"),
                    trailing: IconButton(
                        onPressed: () {}, icon: Icon(Icons.dialer_sip)),
                  );
                },
                separatorBuilder: (context, index) => kHeight5,
              )
            ],
          ),
        ),
      )),
    );
  }
}
