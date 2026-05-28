import 'package:flutter/material.dart';
import 'package:project_mobile/ui/auth/login_page.dart';

class OpenSliderPage extends StatelessWidget {
  const OpenSliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Halaman Slider / Onboarding'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman Login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              child: const Text('Lanjut ke Login'),
            ),
          ],
        ),
      ),
    );
  }
}