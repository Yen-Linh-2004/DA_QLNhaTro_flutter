import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/PhongTro.dart';

class PhongTroProvider extends ChangeNotifier {
  bool isLoading = false;
  List<PhongTro> PhongTroList = [];

  Future<void> fetchPhongTro() async {
    try {
      isLoading = true;
      notifyListeners();
      isLoading = false;
      notifyListeners();

      final fullUrl = ApiRoutes.phongtro.dio.options.baseUrl + Endpoints.phongtro;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.phongtro.getAllPhongTro();
      final rawData = response.data['data']; 

      print("Dữ liệu PhongTro trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      // --- Parse an toàn: list hoặc object ---
      if (rawData is List) {
        PhongTroList = rawData
            .map((e) => PhongTro.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        PhongTroList = [PhongTro.fromJson(rawData as Map<String, dynamic>)];
      } else {
        PhongTroList = [];
        print("⚠️ Dữ liệu PhongTro không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.phongtro.dio.options.baseUrl + Endpoints.phongtro;
      print("Gọi API PhongTro: $fullUrl");
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
      isLoading = false;
      notifyListeners();

      final fullUrl = ApiRoutes.phongtro.dio.options.baseUrl + Endpoints.phongtrong;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.phongtro.getAllPhongTrong();
      final rawData = response.data['data']; 

      print("Dữ liệu Phong trong trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

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
