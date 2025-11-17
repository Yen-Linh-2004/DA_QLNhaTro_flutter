import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static Dio get instance => _dio;
  static Future<dynamic> get(String url) async {
    final response = await http.get(Uri.parse(url));
    return _handleResponse(response);
  }

  static Future<dynamic> post(String url, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> put(String url, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String url) async {
    final response = await http.delete(Uri.parse(url));
    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return json.decode(res.body);
    } else {
      throw Exception("API Error: ${res.statusCode} - ${res.body}");
    }
  }
}
