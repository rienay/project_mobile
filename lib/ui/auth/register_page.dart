import 'package:flutter/material.dart';
// Import file login_page.dart sudah ditambahkan
import 'package:project_mobile/ui/auth/login_page.dart';
import 'package:project_mobile/helpers/api_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;
  bool isObsecurePassword = true;
  bool isObsecureConfirm = true;
  bool rememberMe = false;

  Future<void> register() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email dan password tidak boleh kosong!')));
      return;
    }
    
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password tidak cocok!')));
      return;
    }

    if (!rememberMe) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Anda harus menyetujui Terms / Remember me')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Memanggil fungsi register
      await ApiHelper.register(emailController.text, passwordController.text);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registrasi sukses! Silakan Log In.')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal: $e')));
      }
    }
    
    if (mounted) {
    setState(() {
      isLoading = false;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPink = Color(0xFFFF40A3); 

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Top Branding
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.favorite, color: primaryPink, size: 22),
                          const SizedBox(width: 8),
                          const Text(
                            'Love Wedding',
                            style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.bold, 
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Judul Utama
                      const Text(
                        'Sign in to your\nAccount',
                        style: TextStyle(
                          fontSize: 34,
                          height: 1.2,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Sub-judul
                      Text(
                        'Enter your email and password to sign in',
                        style: TextStyle(
                          color: Colors.grey[500], 
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Field: Email
                      Text('Email', style: TextStyle(color: Colors.grey[600], fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: primaryPink, width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Field: Password 1
                      Text('Password', style: TextStyle(color: Colors.grey[600], fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: passwordController,
                        obscureText: isObsecurePassword,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: primaryPink, width: 1.5),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObsecurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setState(() {
                                isObsecurePassword = !isObsecurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Field: Password 2
                      Text('Password', style: TextStyle(color: Colors.grey[600], fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: isObsecureConfirm,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: primaryPink, width: 1.5),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObsecureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setState(() {
                                isObsecureConfirm = !isObsecureConfirm;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Remember Me & Forgot Password
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
                                  side: BorderSide(color: Colors.grey.shade400, width: 1.5),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text('Remember me', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Forgot Password ?',
                              style: TextStyle(color: primaryPink, fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Tombol Sign Up
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryPink,
                            foregroundColor: Colors.white,
                            elevation: 0, 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                              : const Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 36),

                      // Or Divider
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade200, thickness: 1)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('Or', style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade200, thickness: 1)),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Continue with Google
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Colors.grey.shade200),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/google.png', height: 24, width: 24),
                            const SizedBox(width: 8),
                            const Text('Continue with Google', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Continue with Facebook
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Colors.grey.shade200),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/facebook.png', height: 24, width: 24),
                            const SizedBox(width: 12),
                            const Text('Continue with Facebook', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Bagian bawah: Navigasi ke halaman LoginPage saat ditekan
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? ', style: TextStyle(color: Colors.grey[500], fontSize: 14)),
                  GestureDetector(
                    onTap: () {
                      // Fungsi perpindahan halaman ditambahkan di sini
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Log In', 
                      style: TextStyle(color: primaryPink, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}