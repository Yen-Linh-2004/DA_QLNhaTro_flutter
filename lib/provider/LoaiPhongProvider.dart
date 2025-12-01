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
      final rawData = response.data['data']; 

      print("Dữ liệu LoaiPhong trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

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

  Future<void> createLoaiPhong(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await ApiRoutes.loaiPhong.create(data);
      final newLoaiPhong = LoaiPhong.fromJson(response.data['data']);
      loaiPhongList.add(newLoaiPhong);

      print("Thêm loại phòng thành công: ${newLoaiPhong.tenLoaiPhong}");
      notifyListeners();
    } catch (e, stacktrace) {
      print(" Lỗi khi tạo loại phòng: $e");
      print("Stacktrace: $stacktrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateLoaiPhong(int id, Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.loaiPhong.update(id, data);
      final updatedLoaiPhong = LoaiPhong.fromJson(response.data['data']);
      final index = loaiPhongList.indexWhere((lp) => lp.id == id);
      if (index != -1) {
        loaiPhongList[index] = updatedLoaiPhong;
      }
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi update loại phòng: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteLoaiPhong(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      await ApiRoutes.loaiPhong.delete(id);
      loaiPhongList.removeWhere((lp) => lp.id == id);
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi delete loại phòng: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
