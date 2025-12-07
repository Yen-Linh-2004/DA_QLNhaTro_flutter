
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

  Future<Response> getPhongTroById(int id) async {
    return await dio.get(
      Endpoints.phongtroId(id),
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
  
 Future<Response> create(Map<String, dynamic> data) async {
    return await dio.post(
      Endpoints.phongtro,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer ${AppConfig.token}'},
      ),
    );
  }

  Future<Response> update(int id, Map<String, dynamic> data) async {
    return await dio.put(
      "${Endpoints.phongtroId(id)}",
      data: data,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> delete(int id) async {
    return await dio.delete(
      "${Endpoints.phongtroId(id)}",
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
  
  Future<Response> getAllPhongTrong() async {
    return await dio.get(
      Endpoints.phongtrong,
      options: Options(headers: {}),
    );
  }
    
  Future<Response> getPhongTrongById(int id) async {
    return await dio.get(Endpoints.phongtrongId(id));
  }

}
