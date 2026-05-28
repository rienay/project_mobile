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

  double _circleSize = 0.0;
  bool _showHeart = false;

  @override
  void initState() {
    super.initState();
    startSplash();
  }

  Future<void> startSplash() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _circleSize = 150.0;
      });
    }

    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        _showHeart = true;
      });
    }

    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

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
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: _showHeart
              ? const Icon(
                  Icons.favorite,
                  key: ValueKey('heart'),
                  color: Colors.pinkAccent,
                  size: 150,
                )
              : AnimatedContainer(
                  key: const ValueKey('circle'),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutBack, // Memberikan efek memantul saat membesar
                  width: _circleSize,
                  height: _circleSize,
                  decoration: const BoxDecoration(
                    color: Colors.pinkAccent,
                    shape: BoxShape.circle,
                  ),
                ),
        ),
      ),
    );
  }
}