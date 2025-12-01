import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/service/apiService.dart';

class PhieuDatCocSerrvice {
  final Dio dio = ApiService.createDio();

  Future<Response> getAllPhieuDatCoc() async {
    return await dio.get(
      Endpoints.phieudatcoc,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> getPhieuDatCocId(int id) async {
    return await dio.get(
      Endpoints.phieudatcocId(id),
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

   Future<Response> create(Map<String, dynamic> data) async {
    return await dio.post(
      Endpoints.phieudatcoc,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer ${AppConfig.token}'},
      ),
    );
  }

  Future<Response> update(int id, Map<String, dynamic> data) async {
    return await dio.put(
      "${Endpoints.phieudatcoc}/$id",
      data: data,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> delete(int id) async {
    return await dio.delete(
      "${Endpoints.phieudatcoc}/$id",
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}