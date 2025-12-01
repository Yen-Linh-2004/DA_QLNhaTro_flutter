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

   Future<Response> create(Map<String, dynamic> data) async {
    return await dio.post(
      Endpoints.thongbao,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer ${AppConfig.token}'},
      ),
    );
  }

  Future<Response> update(int id, Map<String, dynamic> data) async {
    return await dio.put(
      "${Endpoints.thongbao}/$id",
      data: data,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> delete(int id) async {
    return await dio.delete(
      "${Endpoints.thongbao}/$id",
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}