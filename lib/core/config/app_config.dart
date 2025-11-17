

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get apiUrl => dotenv.env['API_URL'] ?? '';
  static const int timeout = 10000;
}
