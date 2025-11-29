import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/service/apiService.dart';

class CustomerSerrvice {
  final Dio dio = ApiService.createDio();

  Future<Response> getInvoice() async {
    return await dio.get(
      Endpoints.invoices,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> getInvoicelast() async {
    return await dio.get(
      Endpoints.invoiceslast,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
  
  Future<Response> getRoomInfo() async {
    return await dio.get(
      Endpoints.room,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> getContractInfo() async {
    return await dio.get(
      Endpoints.contract,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> getRoomStatus() async {
    return await dio.get(
      Endpoints.roomStatus,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}