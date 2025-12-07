import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/data/model/PhongTro.dart';

class PhongTroProvider extends ChangeNotifier {
  bool isLoadingList = false;
  bool isLoadingDetail = false;
  bool isLoading = false;
  bool isLoadingEntity = false;
  
  List<PhongTro> PhongTroList = [];
  List<PhongTro> phongTrongList = [];
  PhongTro? PhongTroDetail;
  PhongTro? PhongTrongDetail;

  Future<void> fetchPhongTro() async {
    isLoadingList = true;
    notifyListeners();

    try {
      final response = await ApiRoutes.phongtro.getAllPhongTro();

      dynamic data;
      if (response.data is String) {
        data = jsonDecode(response.data);
      } else {
        data = response.data;
      }

      if (data['data'] != null && data['data'] is List) {
        PhongTroList = (data['data'] as List)
            .map((e) => PhongTro.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        PhongTroList = [];
        print("Response không có key 'data' hoặc không phải List");
      }
    } catch (e, stacktrace) {
      print("Lỗi fetch PhongTro: $e");
      print(stacktrace);
      PhongTroList = [];
    } finally {
      isLoadingList = false;
      notifyListeners();
    }
  }

  Future<void> fetchPhongTroById(int id) async {
    isLoadingDetail = true;
    notifyListeners();
    try {
      final response = await ApiRoutes.phongtro.getPhongTroById(id);
      if (response.statusCode != 200) {
        PhongTroDetail = null;
        return;
      }
      final rawData = response.data['data'];
      if (rawData is Map) {
        PhongTroDetail = PhongTro.fromJson(rawData as Map<String, dynamic>);
      } else if (rawData is List && rawData.isNotEmpty) {
        PhongTroDetail = PhongTro.fromJson(rawData.first);
      } else {
        PhongTroDetail = null;
      }
    } catch (e, stacktrace) {
      print("Lỗi fetchPhongTroById: $e");
      print(stacktrace);
      PhongTroDetail = null;
    } finally {
      isLoadingDetail = false;
      notifyListeners();
    }
  }

Future<void> createPhongTro(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await ApiRoutes.phongtro.create(data);
      if (response.data == null || response.data['data'] == null) {
        print("⚠ Backend không trả về trường 'data'");
        return;
      }
      final newLoaiPhong = PhongTro.fromJson(response.data['data']);
      phongTrongList.add(newLoaiPhong);
      print("Thêm phòng thành công: ${newLoaiPhong.tenLoaiPhong}");
      notifyListeners();
    } on DioException catch (e) {
      print("Lỗi Dio (tạo phòng): ${e.response?.data}");
    } catch (e, stacktrace) {
      print("Lỗi không xác định: $e");
      print("Stacktrace: $stacktrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }



  // =============================================
  // =============================================
  Future<void> fetchPhongTrong() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiRoutes.phongtro.getAllPhongTrong();
      print("Gọi API: $response");
      if (response.statusCode != 200) {
        phongTrongList = [];
        return;
      }
      final rawData = response.data['data'];
      if (rawData is List) {
        phongTrongList = rawData.map((e) => PhongTro.fromJson(e as Map<String, dynamic>)).toList();
        print("Dữ liệu phòng trống trả về: $rawData");
      } else {
        print("Dữ liệu trả về không phải List: $rawData");
        phongTrongList = [];
      }
    } catch (e, stacktrace) {
      print("Lỗi fetchPhongTrong: $e");
      print(stacktrace);
      phongTrongList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<PhongTro?> getPhongTrongById(int id) async {
    try {
      final response = await ApiRoutes.phongtro.getPhongTrongById(id);
      if (response.statusCode != 200) {
        return null;
      }
      final rawData = response.data['data'];
      if (rawData is Map<String, dynamic>) {
        return PhongTro.fromJson(rawData);
      }
      if (rawData is List && rawData.isNotEmpty) {
        return PhongTro.fromJson(
            rawData.first as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print("Repository Error (getPhongTroById): $e");
      return null;
    }
  }

}
