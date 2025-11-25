

// class AppConfig {
//   static String get apiUrl => dotenv.env['API_URL'] ?? '';
//   static const int timeout = 10000;
// }
class AppConfig {
  static const String apiUrl = "http://localhost:8000/api";
  static String? token;
}