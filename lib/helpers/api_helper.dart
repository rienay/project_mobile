import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  // IP Laptop Anda hasil ipconfig (Ubah jika IP laptop Anda berubah!)
  static const String ipAddress = '192.168.11.240';
  
  // Jika berjalan di Web/Chrome, gunakan 'localhost'. Jika di Mobile, gunakan IP laptop.
  static String get activeHost => kIsWeb ? 'localhost' : ipAddress;
  
  static String get baseUrl => 'http://$activeHost/ci/lovewedding/public/index.php/api';

  // 1. Test Koneksi API
  static Future<Map<String, dynamic>> testConnection() async {
    final response = await http.get(Uri.parse('$baseUrl/test'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal terhubung ke API CI4');
    }
  }

  // 2. Ambil Data Layanan
  static Future<List<dynamic>> getLayanan() async {
    final response = await http.get(Uri.parse('$baseUrl/layanan'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil data layanan');
    }
  }

  // 3. Ambil Data Vendor
  static Future<List<dynamic>> getVendor() async {
    final response = await http.get(Uri.parse('$baseUrl/vendor'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil data vendor');
    }
  }

  // 4. Ambil Data Galeri Vendor
  static Future<List<dynamic>> getVendorGallery() async {
    final response = await http.get(Uri.parse('$baseUrl/vendor-gallery'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil data galeri vendor');
    }
  }

  // 5. Ambil Data Booking
  static Future<List<dynamic>> getBooking() async {
    final response = await http.get(Uri.parse('$baseUrl/booking'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil data booking');
    }
  }

  // 6. Ambil Data User
  static Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/user'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil data user');
    }
  }

  // 7. Ambil Data Detail User
  static Future<List<dynamic>> getUserDetails() async {
    final response = await http.get(Uri.parse('$baseUrl/user-detail'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil data detail user');
    }
  }

  // 8. Ambil Data Review Vendor
  static Future<List<dynamic>> getVendorReviews() async {
    final response = await http.get(Uri.parse('$baseUrl/vendor-review'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil data review vendor');
    }
  }

  // Simulasi Register
  static Future<void> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('registered_email', email);
    await prefs.setString('registered_password', password);
  }

  // Simulasi Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? regEmail = prefs.getString('registered_email');
    String? regPassword = prefs.getString('registered_password');

    if (regEmail == email && regPassword == password) {
      await prefs.setString('token', 'dummy_token_123');
      return {'success': true, 'token': 'dummy_token_123'};
    } else {
      if (regEmail == null) {
        throw Exception('Akun belum terdaftar.');
      } else {
        throw Exception('Email atau password salah.');
      }
    }
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // 9. Ambil Data Paket Vendor (Tambahan)
  static Future<List<dynamic>> getPaketVendor() async {
    final response = await http.get(Uri.parse('$baseUrl/paket-vendor'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil data paket vendor');
    }
  }

  // 10. Helper format URL Gambar (Localhost translation)
  static String formatImageUrl(String? url) {
    if (url == null || url.isEmpty) {
      return 'assets/images/default_vendor.png';
    }
    // Replace localhost atau localhost:8080 dengan Host Aktif (localhost / IP Laptop)
    String cleanUrl = url;
    if (cleanUrl.contains('localhost:8080')) {
      cleanUrl = cleanUrl.replaceAll('localhost:8080', '$activeHost/ci/lovewedding/public');
    } else if (cleanUrl.contains('localhost')) {
      cleanUrl = cleanUrl.replaceAll('localhost', '$activeHost/ci/lovewedding/public');
    }
    return cleanUrl;
  }

  // 11. Helper format URL Gambar Layanan
  static String formatLayananImageUrl(String? filename) {
    if (filename == null || filename.isEmpty) {
      return '';
    }
    if (filename.startsWith('http')) {
      return formatImageUrl(filename);
    }
    return 'http://$activeHost/ci/lovewedding/public/uploads/layanan/$filename';
  }
}