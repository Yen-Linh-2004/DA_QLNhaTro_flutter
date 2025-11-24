import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/data/model/TaiKhoan.dart';

class AuthService {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConfig.apiUrl));
  String? _token;

  // Lấy token hiện tại
  String? get token => _token;

  // Đăng ký (tương ứng với AuthController@register)
  Future<TaiKhoan> register(Map<String, dynamic> data) async {
    final response = await dio.post('${AppConfig.apiUrl}/auth/register', data: data);
    final userJson = response.data['data']['taiKhoan'];
    final user = TaiKhoan.fromJson(userJson);

    // Lưu token nếu có
    // _token = response.data['data']['access_token'];

    return user;
  }

  // Đăng nhập (tương ứng với AuthController@login)
  Future<TaiKhoan> login(String tenDangNhap, String matKhau) async {
    final response = await dio.post('${AppConfig.apiUrl}/auth/login', data: {
      'TenDangNhap': tenDangNhap,
      'password': matKhau,
    });

    final userJson = response.data['data']['taiKhoan'];
    final user = TaiKhoan.fromJson(userJson);

    // Lưu token
    _token = response.data['data']['access_token'];

    return user;
  }

  // Đăng xuất (tương ứng với AuthController@logout)
  Future<void> logout(String s) async {
    if (_token == null) return;

    await dio.post(
      '${AppConfig.apiUrl}/auth/logout',
      // options: Options(
      //   headers: {'Authorization': 'Bearer $_token'},
      // ),
    );

    _token = null;
  }

  getAccessToken() {}
}
