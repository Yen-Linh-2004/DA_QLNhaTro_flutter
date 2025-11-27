import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static const String apiUrl = "http://localhost:8000/api";
  static String? token;

  static Future<void> saveToken(String token) async {
    AppConfig.token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  static Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    print("Token đã load từ SharedPreferences: $token");
  }

  static Future<void> clearToken() async {
    token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }
}