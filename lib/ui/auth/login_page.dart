import 'package:flutter/material.dart';
import 'package:project_mobile/helpers/api_helper.dart';
import 'package:project_mobile/ui/home/open_slider_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool isLoading = false;
  bool isObsecure = true;

  Future<void> login() async {

    setState(() {
      isLoading = true;
    });

    try {

      await ApiHelper.login(
        emailController.text,
        passwordController.text,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const OpenSliderPage(),
          ),
        );
      }

    } catch (e) {

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // Menghilangkan teks "Exception: " agar pesan error lebih rapi
            content: Text(e.toString().replaceAll('Exception: ', '')),
          ),
        );
      }

    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                'Love Wedding',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,
                obscureText: isObsecure,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                    icon: Icon(
                      isObsecure
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : login,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}