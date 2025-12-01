import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Dio createDio() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConfig.apiUrl,
      headers: {
        "Content-Type": "application/json",
      },
    );

    Dio dio = Dio(options);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? token = prefs.getString("token");
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    );

    return dio;
  }
}
