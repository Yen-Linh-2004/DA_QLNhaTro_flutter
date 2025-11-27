import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/LoaiPhong.dart';
class LoaiPhongProvider extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> loaiPhongList = [];

Future<void> fetchLoaiPhong() async {
  try {
    isLoading = true;
    notifyListeners();

    final fullUrl = ApiRoutes.loaiPhong.dio.options.baseUrl + Endpoints.loaiPhong;
    print("Gọi API LoaiPhong: $fullUrl");

    final response = await ApiRoutes.loaiPhong.getAll();
    final rawData = response.data['data']; // Lấy đúng key 'data' nếu API trả { data: [...] }

    print("Dữ liệu LoaiPhong trả về: $rawData");
    print("Type of rawData: ${rawData.runtimeType}");

    // --- Parse an toàn: object hoặc list ---
    if (rawData is List) {
      loaiPhongList = rawData
          .map((e) => LoaiPhong.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (rawData is Map) {
      loaiPhongList = [LoaiPhong.fromJson(rawData as Map<String, dynamic>)];
    } else {
      loaiPhongList = [];
    }

  } catch (e, stacktrace) {
    final fullUrl = ApiRoutes.loaiPhong.dio.options.baseUrl + Endpoints.loaiPhong;
    print("Gọi API LoaiPhong: $fullUrl");
    print("Lỗi fetch loại phòng: $e");
    print(stacktrace);
  } finally {
    isLoading = false;
    notifyListeners();
  }
}


}
