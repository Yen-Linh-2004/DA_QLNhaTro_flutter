import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/TaiKhoan.dart';
import 'package:dio/dio.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  TaiKhoan? taiKhoan;
  String? accessToken;

  final Dio _dio = ApiRoutes.auth.dio;

  /// Cập nhật token vào header
  void _setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Đăng nhập
  Future<void> login(String tenDangNhap, String matKhau) async {
    isLoading = true;
    notifyListeners();

    try {
      final fullUrl = _dio.options.baseUrl + Endpoints.login;
      print("🔥 Gọi API login: $fullUrl");

      final response = await _dio.post(Endpoints.login, data: {
        'TenDangNhap': tenDangNhap,
        'password': matKhau,
      });
      print("Dữ liệu login trả về: ${response.data}");
      taiKhoan = TaiKhoan.fromJson(response.data['data']['user']);
      accessToken = response.data['data']['access_token'];

      if (accessToken != null) {
        _setAuthToken(accessToken!);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("Lỗi login: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        print("Lỗi login: ${e.message}");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Đăng ký
  Future<void> register(Map<String, dynamic> registerData) async {
    isLoading = true;
    notifyListeners();

    try {
      final fullUrl = _dio.options.baseUrl + Endpoints.register;
      print("🔥 Gọi API register: $fullUrl");

      final response = await _dio.post(Endpoints.register, data: registerData);

      print("Dữ liệu register trả về: ${response.data}");

      taiKhoan = TaiKhoan.fromJson(response.data['data']['user']);
      accessToken = response.data['data']['access_token'];

      if (accessToken != null) {
        _setAuthToken(accessToken!);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("Lỗi register: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        print("Lỗi register: ${e.message}");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Đăng xuất
  Future<void> logout() async {
    if (accessToken == null) return;

    isLoading = true;
    notifyListeners();

    try {
      final fullUrl = _dio.options.baseUrl + Endpoints.logout;
      print("🔥 Gọi API logout: $fullUrl");

      await _dio.post(Endpoints.logout);

      _dio.options.headers.remove('Authorization');

      taiKhoan = null;
      accessToken = null;

      print("Đăng xuất thành công");
    } on DioError catch (e) {
      if (e.response != null) {
        print("Lỗi logout: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        print("Lỗi logout: ${e.message}");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool get isAuthenticated => taiKhoan != null && accessToken != null;
}
