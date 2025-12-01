import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/TaiKhoan.dart';

class TaiKhoanProvider extends ChangeNotifier {
  bool isLoading = false;
  List<TaiKhoan> TaiKhoanList = [];

  Future<void> fetchTaiKhoan() async {
    try {
      isLoading = true;
      notifyListeners();
      isLoading = false;
      notifyListeners();

      final fullUrl = ApiRoutes.taikhoan.dio.options.baseUrl + Endpoints.taikhoan;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.taikhoan.getAllTaiKhoan();
      final rawData = response.data['data']; 

      print("Dữ liệu TaiKhoan trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      // --- Parse an toàn: list hoặc object ---
      if (rawData is List) {
        TaiKhoanList = rawData
            .map((e) => TaiKhoan.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        TaiKhoanList = [TaiKhoan.fromJson(rawData as Map<String, dynamic>)];
      } else {
        TaiKhoanList = [];
        print("Dữ liệu TaiKhoan không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.taikhoan.dio.options.baseUrl + Endpoints.taikhoan;
      print("Gọi API TaiKhoan: $fullUrl");
      print("Lỗi fetch TaiKhoan: $e");
      print(stacktrace);
      TaiKhoanList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
