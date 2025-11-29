import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/HopDong.dart';

class HopDongProvider extends ChangeNotifier {
  bool isLoading = false;
  List<HopDong> HopDongList = [];

  Future<void> fetchHopDong() async {
    try {
      isLoading = true;
      notifyListeners();
      isLoading = false;
      notifyListeners();

      final fullUrl = ApiRoutes.hopdong.dio.options.baseUrl + Endpoints.hopdong;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.hopdong.getAllHopDong();
      final rawData = response.data['data']; 

      print("Dữ liệu HopDong trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      // --- Parse an toàn: list hoặc object ---
      if (rawData is List) {
        HopDongList = rawData
            .map((e) => HopDong.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        HopDongList = [HopDong.fromJson(rawData as Map<String, dynamic>)];
      } else {
        HopDongList = [];
        print("⚠️ Dữ liệu HopDong không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.hopdong.dio.options.baseUrl + Endpoints.hopdong;
      print("Gọi API HopDong: $fullUrl");
      print("Lỗi fetch HopDong: $e");
      print(stacktrace);
      HopDongList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
