import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/ViPham.dart';

class ViPhamProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ViPham> ViPhamList = [];

  Future<void> fetchViPham() async {
    try {
      isLoading = true;
      notifyListeners();
      isLoading = false;
      notifyListeners();

      final fullUrl = ApiRoutes.vipham.dio.options.baseUrl + Endpoints.vipham;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.vipham.getAllViPham();
      final rawData = response.data['data']; 

      print("Dữ liệu ViPham trả về: $rawData");
      
      if (rawData is List) {
        ViPhamList = rawData
            .map((e) => ViPham.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        ViPhamList = [ViPham.fromJson(rawData as Map<String, dynamic>)];
      } else {
        ViPhamList = [];
        print("⚠️ Dữ liệu ViPham không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.vipham.dio.options.baseUrl + Endpoints.vipham;
      print("Gọi API ViPham: $fullUrl");
      print("Lỗi fetch ViPham: $e");
      print(stacktrace);
      ViPhamList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
