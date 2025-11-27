import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/service/apiService.dart';

class DichvuSerrvice {
  final Dio dio = ApiService.createDio();

  Future<Response> getAllDichVu() async {
    return await dio.get(
      Endpoints.dichvu,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}