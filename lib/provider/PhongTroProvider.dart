import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/PhongTro.dart';

class PhongTroProvider extends ChangeNotifier {
  bool isLoading = false;
  List<PhongTro> PhongTroList = [];

  get errorMessage => null;

Future<void> fetchPhongTro() async {
  try {
    isLoading = true;
    notifyListeners();

    final response = await ApiRoutes.phongtro.getAllPhongTro();

    dynamic data;
    if (response.data is String) {
      // Nếu response là String → parse JSON thủ công
      try {
        data = jsonDecode(response.data);
      } catch (e) {
        print("⚠️ JSON decode failed: $e");
        print("RAW response (first 500 chars): ${response.data.substring(0, 500)}");
        PhongTroList = [];
        return;
      }
    } else {
      data = response.data;
    }

    // Kiểm tra key 'data'
    if (data['data'] != null && data['data'] is List) {
      PhongTroList = (data['data'] as List)
          .map((e) => PhongTro.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      PhongTroList = [];
      print("⚠️ Response không có key 'data' hoặc không phải List");
    }
  } catch (e, stacktrace) {
    print("Lỗi fetch PhongTro: $e");
    print(stacktrace);
    PhongTroList = [];
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

  Future<void> fetchPhongTrong() async {
    try {
      isLoading = true;
      notifyListeners();

      final fullUrl = ApiRoutes.phongtro.dio.options.baseUrl + Endpoints.phongtrong;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.phongtro.getAllPhongTrong();
      final rawData = response.data['data']; 

      print("Dữ liệu Phong trong trả về: $rawData");

      // --- Parse an toàn: list hoặc object ---
      if (rawData is List) {
        PhongTroList = rawData
            .map((e) => PhongTro.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        PhongTroList = [PhongTro.fromJson(rawData as Map<String, dynamic>)];
      } else {
        PhongTroList = [];
        print("⚠️ Dữ liệu PhongTrong không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.phongtro.dio.options.baseUrl + Endpoints.phongtrong;
      print("Gọi API PhongTrong: $fullUrl");
      print("Lỗi fetch PhongTrong: $e");
      print(stacktrace);
      PhongTroList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}
