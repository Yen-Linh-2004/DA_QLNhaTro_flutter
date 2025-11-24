import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
class LoaiPhongProvider extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> loaiPhongList = [];

 Future<void> fetchLoaiPhong() async {
  try {
    isLoading = true;
    notifyListeners();

    // In ra URL đầy đủ trước khi gọi API
    final fullUrl = ApiRoutes.loaiPhong.dio.options.baseUrl + Endpoints.loaiPhong;
    print("🔥 Gọi API LoaiPhong: $fullUrl");

    final response = await ApiRoutes.loaiPhong.getAll();

    // In ra dữ liệu trả về để debug
    print("Dữ liệu LoaiPhong trả về: ${response.data}");

    // Cập nhật vào list
    loaiPhongList = response.data;

  } catch (e, stacktrace) {
    final fullUrl = ApiRoutes.loaiPhong.dio.options.baseUrl + Endpoints.loaiPhong;
    print("🔥 Gọi API LoaiPhong: $fullUrl");
    print("Lỗi fetch loại phòng: $e");
    print(stacktrace);
  } finally {
    isLoading = false;
    notifyListeners();
  }
}


}
