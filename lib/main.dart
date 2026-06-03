import 'package:flutter/material.dart';
import 'package:project_mobile/ui/profile/profile_page.dart';
import 'package:project_mobile/ui/vendor/vendor_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wedding Vendor App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.pink,
      ),
      home: const ProfilePage(),
    );
  }
}