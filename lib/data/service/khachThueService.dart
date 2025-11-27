
import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/service/apiService.dart';

class KhachThueService {
  final Dio dio = ApiService.createDio();

  Future<Response> getAllKhachThue() async {
    return await dio.get(
      Endpoints.khachthue,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> getById(int id) async {
    return await dio.get(
      Endpoints.khachThueId(id), 
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}
