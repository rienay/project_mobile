import 'package:flutter/material.dart';
import 'ui/home/vendor_list_page.dart'; // Import file daftar vendor yang kita buat tadi

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
        brightness: Brightness.dark, // Set tema dark biar serasi sama designdark-mu
        primarySwatch: Colors.pink,
      ),
      // DI SINI KUNCINYA: Langsung arahkan home ke VendorListPage()
      home: const VendorListPage(), 
    );
  }
}