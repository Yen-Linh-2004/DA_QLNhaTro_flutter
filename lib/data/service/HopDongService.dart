import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/service/apiService.dart';

class HopDongSerrvice {
  final Dio dio = ApiService.createDio();

  Future<Response> getAllHopDong() async {
    return await dio.get(
      Endpoints.hopdong,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}