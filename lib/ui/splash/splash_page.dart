import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_mobile/ui/auth/login_page.dart';
import 'package:project_mobile/ui/home/open_slider_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    startSplash();
  }

  Future<void> startSplash() async {
    await Future.delayed(const Duration(seconds: 3));

    // kemungkinan cek login/session
    bool isLogin = false;

    if (isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OpenSliderPage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 120,
            ),
            const SizedBox(height: 20),
            const Text(
              'Love Wedding',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}