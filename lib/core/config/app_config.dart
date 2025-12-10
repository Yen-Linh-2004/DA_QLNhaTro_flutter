import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static const String apiUrl = "http://10.0.2.2:8000/api";
  // static const String apiUrl = "http://localhost:8000/api";
  
  static String? token;
  static int? maquyen;

  static Future<void> saveToken(String token) async {
    AppConfig.token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);  
  }

  static Future<String?> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    print("Token đã load từ SharedPreferences: $token");
    return token;
  }

  static Future<void> clearToken() async {
    token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }
}