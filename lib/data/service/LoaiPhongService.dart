import 'package:dio/dio.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import '../../core/config/app_config.dart';

class LoaiPhongService {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConfig.apiUrl));

  Future<Response> getAll() async {
    return await dio.get(
      Endpoints.loaiPhong,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> create(Map<String, dynamic> data) async {
    return await dio.post(
      Endpoints.loaiPhong,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer ${AppConfig.token}'},
      ),
    );
  }

  Future<Response> update(int id, Map<String, dynamic> data) async {
    return await dio.put(
      "${Endpoints.loaiPhong}/$id",
      data: data,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> delete(int id) async {
    return await dio.delete(
      "${Endpoints.loaiPhong}/$id",
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}
