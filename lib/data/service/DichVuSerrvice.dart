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

   Future<Response> create(Map<String, dynamic> data) async {
    return await dio.post(
      Endpoints.dichvu,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer ${AppConfig.token}'},
      ),
    );
  }

  Future<Response> update(int id, Map<String, dynamic> data) async {
    return await dio.put(
      "${Endpoints.dichvu}/$id",
      data: data,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> delete(int id) async {
    return await dio.delete(
      "${Endpoints.dichvu}/$id",
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}