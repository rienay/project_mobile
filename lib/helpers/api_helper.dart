import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {

  static const String baseUrl =
      'https://your-api-url.com/api';

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {

    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {

      SharedPreferences prefs =
          await SharedPreferences.getInstance();

      await prefs.setString(
        'token',
        data['token'],
      );

      return data;

    } else {

      throw Exception(
        data['message'] ?? 'Login gagal',
      );

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

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    await prefs.clear();

  }
}