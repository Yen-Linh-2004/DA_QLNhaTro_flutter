
import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/service/apiService.dart';

class NoiQuyService {
  final Dio dio = ApiService.createDio();

  Future<Response> getAllNoiQuy() async {
    return await dio.get(
      Endpoints.noiquy,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

    Future<Response> create(Map<String, dynamic> data) async {
    return await dio.post(
      Endpoints.noiquy,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer ${AppConfig.token}'},
      ),
    );
  }

  Future<Response> update(int id, Map<String, dynamic> data) async {
    return await dio.put(
      "${Endpoints.noiquy}/$id",
      data: data,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> delete(int id) async {
    return await dio.delete(
      "${Endpoints.noiquy}/$id",
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}
