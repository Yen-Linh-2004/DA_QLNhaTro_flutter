import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/ThietBi.dart';

class ThietBiProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ThietBi> ThietBiList = [];

  Future<void> fetchThietBi() async {
    try {
      isLoading = true;
      notifyListeners();

      final fullUrl = ApiRoutes.thietbi.dio.options.baseUrl + Endpoints.thietbi;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.thietbi.getAllThietBi();
      final rawData = response.data['data']; 

      print("Dữ liệu ThietBi trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      // --- Parse an toàn: list hoặc object ---
      if (rawData is List) {
        ThietBiList = rawData
            .map((e) => ThietBi.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        ThietBiList = [ThietBi.fromJson(rawData as Map<String, dynamic>)];
      } else {
        ThietBiList = [];
        print("⚠️ Dữ liệu ThietBi không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.thietbi.dio.options.baseUrl + Endpoints.thietbi;
      print("Gọi API ThietBi: $fullUrl");
      print("Lỗi fetch ThietBi: $e");
      print(stacktrace);
      ThietBiList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
