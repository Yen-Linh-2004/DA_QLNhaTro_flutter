import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/PhieuDatCoc.dart';

class PhieuDatCocProvider extends ChangeNotifier {
  bool isLoading = false;
  List<PhieuDatCoc> PhieuDatCocList = [];

  Future<void> fetchPhieuDatCoc() async {
    try {
      isLoading = true;
      notifyListeners();
      isLoading = false;
      notifyListeners();

      final fullUrl = ApiRoutes.phieudatcoc.dio.options.baseUrl + Endpoints.phieudatcoc;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.phieudatcoc.getAllPhieuDatCoc();
      final rawData = response.data['data']; 

      print("Dữ liệu PhieuDatCoc trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      // --- Parse an toàn: list hoặc object ---
      if (rawData is List) {
        PhieuDatCocList = rawData
            .map((e) => PhieuDatCoc.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        PhieuDatCocList = [PhieuDatCoc.fromJson(rawData as Map<String, dynamic>)];
      } else {
        PhieuDatCocList = [];
        print("⚠️ Dữ liệu PhieuDatCoc không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.phieudatcoc.dio.options.baseUrl + Endpoints.phieudatcoc;
      print("Gọi API PhieuDatCoc: $fullUrl");
      print("Lỗi fetch PhieuDatCoc: $e");
      print(stacktrace);
      PhieuDatCocList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
