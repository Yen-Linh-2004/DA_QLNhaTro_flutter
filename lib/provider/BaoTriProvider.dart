import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/YeuCauBaoTri.dart';

class BaoTriProvider extends ChangeNotifier {
  bool isLoading = false;
  List<YeuCauBaoTri> BaoTriList = [];

  Future<void> fetchBaoTri() async {
    try {
      isLoading = true;
      notifyListeners();
      isLoading = false;
      notifyListeners();

      final fullUrl = ApiRoutes.baotri.dio.options.baseUrl + Endpoints.baotri;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.baotri.getAllBaoTri();
      final rawData = response.data['data']; 

      print("Dữ liệu BaoTri trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      // --- Parse an toàn: list hoặc object ---
      if (rawData is List) {
        BaoTriList = rawData
            .map((e) => YeuCauBaoTri.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        BaoTriList = [YeuCauBaoTri.fromJson(rawData as Map<String, dynamic>)];
      } else {
        BaoTriList = [];
        print("⚠️ Dữ liệu BaoTri không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.baotri.dio.options.baseUrl + Endpoints.baotri;
      print("Gọi API BaoTri: $fullUrl");
      print("Lỗi fetch BaoTri: $e");
      print(stacktrace);
      BaoTriList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
