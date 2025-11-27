
import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/service/apiService.dart';

class ThietBiService {
  final Dio dio = ApiService.createDio();

  Future<Response> getAllThietBi() async {
    return await dio.get(
      Endpoints.thietbi,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}
