
import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/service/apiService.dart';

class ViPhamService {
  final Dio dio = ApiService.createDio();

  Future<Response> getAllViPham() async {
    return await dio.get(
      Endpoints.vipham,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}
