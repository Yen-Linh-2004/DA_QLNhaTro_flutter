import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/data/model/TaiKhoan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConfig.apiUrl));
  String? _token;
  String? get token => _token;

  // Đăng ký 
  Future<TaiKhoan> register(Map<String, dynamic> data) async {
    final response = await dio.post('${AppConfig.apiUrl}/auth/register', data: data);
    final userJson = response.data['data']['taiKhoan'];
    final user = TaiKhoan.fromJson(userJson);
    return user;
  }

  // Đăng nhập
  Future<TaiKhoan> login(String tenDangNhap, String matKhau) async {
    final response = await dio.post('${AppConfig.apiUrl}/auth/login', data: {
      'TenDangNhap': tenDangNhap,
      'password': matKhau,
    });

    final userJson = response.data['data']['user'];
    final user = TaiKhoan.fromJson(userJson);
    final token = response.data['data']['access_token'];

    AppConfig.token = token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    return user;
  }

  // Đăng xuất 
  Future<void> logout(String s) async {
    if (_token == null) return;
    await dio.post('${AppConfig.apiUrl}/auth/logout');
    _token = null;
  }

  getAccessToken() {}
}
