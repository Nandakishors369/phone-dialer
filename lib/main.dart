import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_dialer/presentation/contacts_screen.dart';
import 'package:phone_dialer/presentation/navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392.7, 781.1),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Phone Dialer',
            theme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: Colors.blue,
                brightness: Brightness.dark),
            home: const CustomNavigationBar(),
          );
        });
  }
}
