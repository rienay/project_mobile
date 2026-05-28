import 'package:flutter/material.dart';
import 'package:project_mobile/helpers/api_helper.dart';
import 'package:project_mobile/ui/main_navigator.dart';
import 'package:project_mobile/ui/auth/register_page.dart';

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
  bool rememberMe = false;

  Future<void> login() async {
    // Validasi kosong
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email dan Password harus diisi!')));
      return;
    }

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
            builder: (_) => const MainNavigation(),
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
    // Warna pink disesuaikan agar lebih mendekati desain referensi
    const Color primaryPink = Color(0xFFF43F8B); 

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Agar tombol memenuhi lebar layar
              children: [
                const SizedBox(height: 20),
                
                // Top Branding: Ikon & Love Wedding sejajar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite, color: primaryPink, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Love Wedding',
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.w600, 
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),

                // Judul Login Besar
                const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                
                // Teks Daftar / Register di bawah judul
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account? ', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up', 
                        style: TextStyle(color: primaryPink, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Label & Textfield Email
                Text('Email', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                const SizedBox(height: 8),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: primaryPink),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Label & Textfield Password
                Text('Password', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  obscureText: isObsecure,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: primaryPink),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isObsecure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setState(() {
                          isObsecure = !isObsecure;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Checkbox & Lupa Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            },
                            activeColor: primaryPink,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            side: BorderSide(color: Colors.grey.shade400),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('Remember me', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Aksi lupa password
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(color: primaryPink, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Tombol Log In Pink
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryPink,
                      foregroundColor: Colors.white,
                      elevation: 0, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Text('Log In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 32),

                // Or Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Or', style: TextStyle(color: Colors.grey[500], fontSize: 14)),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                const SizedBox(height: 32),

                // Tombol Continue with Google
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/google.png', height: 24, width: 24),
                      const SizedBox(width: 12),
                      const Text('Continue with Google', style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Tombol Continue with Facebook
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/facebook.png', height: 24, width: 24),
                      const SizedBox(width: 12),
                      const Text('Continue with Facebook', style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}