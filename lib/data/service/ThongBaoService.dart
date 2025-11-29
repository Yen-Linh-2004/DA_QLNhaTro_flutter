import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/service/apiService.dart';

class ThongBaoSerrvice {
  final Dio dio = ApiService.createDio();

  Future<Response> getAllThongBao() async {
    return await dio.get(
      Endpoints.thongbao,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> getAllThongBaoHeThong() async {
    return await dio.get(
      Endpoints.thongbaohethong,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}