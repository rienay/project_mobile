import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_mobile/ui/home/onboarding_page.dart';
import 'package:project_mobile/ui/main_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  double _circleSize = 30;
  bool _showLove = false;

  @override
  void initState() {
    super.initState();
    _startSplash();
  }

  Future<void> _startSplash() async {

    // Delay awal
    await Future.delayed(const Duration(milliseconds: 200));

    if (!mounted) return;

    // Lingkaran membesar sampai fullscreen
    setState(() {
      _circleSize = 9000;
    });

    // Tunggu animasi fullscreen
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    // Tampilkan love kecil
    setState(() {
      _showLove = true;
    });

    // Tunggu sebelum pindah
    await Future.delayed(const Duration(milliseconds: 1400));

    if (!mounted) return;

    // Cek status login (Token)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, animation, __) {
          // Jika ada token, langsung masuk ke Home. Jika tidak, masuk Onboarding
          if (token != null && token.isNotEmpty) {
            return const MainNavigation();
          } else {
            return const OnboardingPage();
          }
        },
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    const Color primaryPink = Color(0xFFE91E63);
    const Color softPinkBg = Color(0xFFFFF5F7);

    return Scaffold(
      backgroundColor: softPinkBg,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [

            // Lingkaran Membesar
            OverflowBox(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeInOutCubic,
                width: _circleSize,
                height: _circleSize,
                decoration: BoxDecoration(
                  color: primaryPink.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Love kecil muncul setelah fullscreen
            AnimatedOpacity(
              duration: const Duration(milliseconds: 700),
              opacity: _showLove ? 1 : 0,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutBack,
                scale: _showLove ? 1 : 0,
                child: const Icon(
                  Icons.favorite,
                  color: primaryPink,
                  size: 42,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}