import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/app_config.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/service/apiService.dart';

class CustomerSerrvice {
  final Dio dio = ApiService.createDio();

  // HÓA DƠN
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

  // HỢP ĐỒNG
  Future<Response> getContractInfo() async {
    return await dio.get(
      Endpoints.contract,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  // PHÒNG TRỌ
  Future<Response> getRoomInfo() async {
    return await dio.get(
      Endpoints.room,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> getRoomStatus() async {
    return await dio.get(
      Endpoints.roomStatus,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  // NỘI QUY VÀ VI PHẠM
  Future<Response> getCustomerViolations() async {
    return await dio.get(
      Endpoints.violations,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> createViolations(Map<String, dynamic> data) async {
    return await dio.post(
      Endpoints.violations,
      data: data,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  // YÊU CẦU BẢO TRÌ
  Future<Response> getMaintenanceRequest() async {
    return await dio.get(
      Endpoints.maintenance,
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }

  Future<Response> getMaintenanceRequestById(int id) async {
    return await dio.get(
      Endpoints.maintenanceId(id),
      options: Options(headers: {'Authorization': 'Bearer ${AppConfig.token}'}),
    );
  }
}