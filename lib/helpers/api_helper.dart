import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {

  static const String baseUrl =
      'https://your-api-url.com/api';

  // Fungsi Simulasi Register
  static Future<void> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulasi loading
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Menyimpan data email dan password untuk simulasi login
    await prefs.setString('registered_email', email);
    await prefs.setString('registered_password', password);
  }

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulasi loading
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Mengambil data yang disimpan saat register
    String? regEmail = prefs.getString('registered_email');
    String? regPassword = prefs.getString('registered_password');

    // Mencocokkan inputan login dengan data register
    if (regEmail == email && regPassword == password) {
      // Jika cocok, buat token login
      await prefs.setString('token', 'dummy_token_123');
      return {'success': true, 'token': 'dummy_token_123'};
    } else {
      if (regEmail == null) {
        throw Exception('Akun belum terdaftar. Silakan Sign Up terlebih dahulu.');
      } else {
        throw Exception('Email atau password salah.');
      }
    }
  }

  static Future<Map<String, dynamic>> getProfile() async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    String token =
        prefs.getString('token') ?? '';

    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getWeddingData() async {

    final response = await http.get(
      Uri.parse('$baseUrl/wedding'),
    );

    return jsonDecode(response.body);
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Hanya hapus token login agar status menjadi logout, 
    // tapi akun yang di-register tidak ikut terhapus.
    await prefs.remove('token');
  }
}