import 'package:flutter_application/data/model/TaiKhoan.dart';
import 'package:flutter_application/data/service/AuthService.dart';

class UserRepository {
  final AuthService userService;
  String? _token;

  UserRepository({required this.userService});

  /// Đăng ký người dùng
  Future<TaiKhoan> register(Map<String, dynamic> registerData) async {
    final taiKhoan = await userService.register(registerData);
    _token = userService.getAccessToken();
    return taiKhoan;
  }

  /// Đăng nhập người dùng
  Future<TaiKhoan> login(String tenDangNhap, String matKhau) async {
    final taiKhoan = await userService.login(tenDangNhap, matKhau);
    _token = userService.getAccessToken(); 
    return taiKhoan;
  }

  /// Đăng xuất người dùng
  Future<void> logout() async {
    if (_token != null) {
      await userService.logout(_token!);
      _token = null;
    }
  }

  /// Lấy token hiện tại
  String? getAccessToken() {
    return _token ?? userService.getAccessToken();
  }

  /// Kiểm tra đăng nhập
  bool get isAuthenticated => getAccessToken() != null;
}
