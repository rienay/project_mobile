// lib/ui/main_navigation.dart
import 'package:flutter/material.dart';
import 'package:project_mobile/ui/home/home_page.dart'; // Sesuaikan nama project kamu

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(), 
    const Center(child: Text('Halaman Vendor')), 
    const Center(child: Text('Halaman Idea')),   
    const Center(child: Text('Halaman Profil')), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF4081), // Warna pink untuk text aktif sesuai Group 123.png
        unselectedItemColor: const Color(0xFF5C6B73), // Warna abu-abu untuk text tidak aktif
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: [
          // 1. HOME
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home.png', width: 24, height: 24, color: const Color(0xFF5C6B73)),
            activeIcon: Image.asset('assets/icons/home.png', width: 24, height: 24, color: const Color(0xFFFF4081)),
            label: 'Home',
          ),
          // 2. VENDOR
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/vendor.png', width: 24, height: 24, color: const Color(0xFF5C6B73)),
            activeIcon: Image.asset('assets/icons/vendor.png', width: 24, height: 24, color: const Color(0xFFFF4081)),
            label: 'Vendor',
          ),
          // 3. IDEA
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/idea.png', width: 24, height: 24, color: const Color(0xFF5C6B73)),
            activeIcon: Image.asset('assets/icons/idea.png', width: 24, height: 24, color: const Color(0xFFFF4081)),
            label: 'Idea',
          ),
          // 4. PROFIL
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/profile.png', width: 24, height: 24, color: const Color(0xFF5C6B73)),
            activeIcon: Image.asset('assets/icons/profile.png', width: 24, height: 24, color: const Color(0xFFFF4081)),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}