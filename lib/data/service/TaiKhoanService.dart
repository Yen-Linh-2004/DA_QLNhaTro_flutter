import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/service/apiService.dart';

class TaiKhoanSerrvice {
  final Dio dio = ApiService.createDio();

  Future<Response> getAllTaiKhoan() async {
    return await dio.get(
      Endpoints.taikhoan,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}