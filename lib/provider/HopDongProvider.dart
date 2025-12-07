import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/HopDong.dart';

class HopDongProvider extends ChangeNotifier {
  bool isLoading = false;
  List<HopDong> HopDongList = [];
  HopDong? HopDongDetail;

  Future<void> fetchHopDong() async {
    try {
      isLoading = true;
      notifyListeners();

      final fullUrl = ApiRoutes.hopdong.dio.options.baseUrl + Endpoints.hopdong;
      print("Gọi API HopDong: $fullUrl");

      final response = await ApiRoutes.hopdong.getAllHopDong();
      final rawData = response.data['data']; 

      print("Dữ liệu HopDong trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      if (rawData is List) {
        HopDongList = rawData
            .whereType<Map<String, dynamic>>() 
            .map((e) => HopDong.fromJson(e))
            .toList();
      } 
      else if (rawData is Map<String, dynamic>) {
        HopDongList = [HopDong.fromJson(rawData)];
      } 
      else {
        print("Dữ liệu HopDong không hợp lệ");
        HopDongList = [];
      }

    } catch (e, stacktrace) {
      print("Lỗi fetch HopDong: $e");
      print(stacktrace);
      HopDongList = [];

    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


    Future<void> fetchHopDongById(int id) async {
    try {
      isLoading = true;
      notifyListeners();
      
      print(" Bắt đầu fetch HopDong với ID: $id");
      final response = await ApiRoutes.hopdong.getHopDongId(id);
      print("Response status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode != 200) {
        print("API trả về lỗi: ${response.statusCode}");
        HopDongDetail = null;
        return;
      }

      final rawData = response.data['data'];
      print("Dữ liệu HopDong thô: $rawData");

      if (rawData is Map) {
        HopDongDetail = HopDong.fromJson(rawData as Map<String, dynamic>);
        print("Chuyển sang model: ${HopDongDetail?.toJson()}");
      } else if (rawData is List && rawData.isNotEmpty) {
        HopDongDetail = HopDong.fromJson(rawData.first as Map<String, dynamic>);
        print("Chuyển sang model từ List: ${HopDongDetail?.toJson()}");
      } else {
        HopDongDetail = null;
        print("Dữ liệu HopDong theo ID không hợp lệ");
      }

    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        print(" Lỗi server (500): ${e.response?.data}");
      } else {
        print(" Lỗi Dio khác: $e");
      }
      HopDongDetail = null;
    } catch (e, stacktrace) {
      print(" Lỗi fetchHopDongById: $e");
      print(stacktrace);
      HopDongDetail = null;
    } finally {
      isLoading = false;
      notifyListeners();
      print("⏹ Kết thúc fetch HopDongById, isLoading = $isLoading");
    }
  }

Future<void> createHopDong(Map<String, dynamic> data) async {
  try {
    isLoading = true;
    notifyListeners();

    final response = await ApiRoutes.hopdong.create(data);

    print("RESPONSE TYPE: ${response.data.runtimeType}");
    print("RESPONSE RAW: ${response.data}");

    // Check response.data validity
    if (response.data == null || response.data is! Map<String, dynamic>) {
      print("⚠ response.data không phải Map<String, dynamic>");
      return;
    }

    final body = response.data as Map<String, dynamic>;

    if (body['data'] == null || body['data'] is! Map<String, dynamic>) {
      print("⚠ Backend không trả về 'data' hoặc sai kiểu");
      return;
    }

    final newHopDong = HopDong.fromJson(body['data']);
    HopDongList.add(newHopDong);

    print("Thêm hợp đồng thành công: ${newHopDong.soHopDong}");
    notifyListeners();
  } on DioException catch (e) {
    print("Lỗi Dio (thêm hợp đồng): ${e.response?.data}");
  } catch (e, stacktrace) {
    print("Lỗi không xác định: $e");
    print("Stacktrace: $stacktrace");
  } finally {
    isLoading = false;
    notifyListeners();
  }
}


  Future<void> updateHopDong(int id, Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.hopdong.update(id, data);
      final updatedHopDong = HopDong.fromJson(response.data['data']);
      final index = HopDongList.indexWhere((lp) => lp.maHopDong == id);
      if (index != -1) {
        HopDongList[index] = updatedHopDong;
      }
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi update hợp đồng: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteHopDong(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      await ApiRoutes.hopdong.delete(id);
      HopDongList.removeWhere((lp) => lp.maHopDong == id);
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi delete hợp đồng: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
