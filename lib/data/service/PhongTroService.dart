
import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/service/apiService.dart';

class PhongtroService {
  final Dio dio = ApiService.createDio();

  Future<Response> getAllPhongTro() async {
    return await dio.get(
      Endpoints.phongtro,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> getAllPhongTrong() async {
    return await dio.get(
      Endpoints.phongtrong,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}
