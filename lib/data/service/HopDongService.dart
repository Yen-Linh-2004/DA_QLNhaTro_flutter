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

  Future<Response> getHopDongId(int id) async {
    return await dio.get(
      Endpoints.hopdongId(id),
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> create(Map<String, dynamic> data) async {
    return await dio.post(
      Endpoints.hopdong,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer ${AppConfig.token}'},
      ),
    );
  }

  Future<Response> update(int id, Map<String, dynamic> data) async {
    return await dio.put(
      "${Endpoints.hopdong}/$id",
      data: data,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> delete(int id) async {
    return await dio.delete(
      "${Endpoints.hopdong}/$id",
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}