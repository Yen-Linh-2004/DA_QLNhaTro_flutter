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
        print("Dữ liệu ViPham không hợp lệ");
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

  Future<void> createViPham(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.vipham.create(data);
      final newViPham = ViPham.fromJson(response.data['data']);
      ViPhamList.add(newViPham);

      print("Thêm bảo trì thành công: ${newViPham.maViPham}");
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi khi tạo bảo trì: $e");
      print("Stacktrace: $stacktrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateViPham(int id, Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.vipham.update(id, data);
      final updatedViPham = ViPham.fromJson(response.data['data']);
      final index = ViPhamList.indexWhere((lp) => lp.maViPham == id);
      if (index != -1) {
        ViPhamList[index] = updatedViPham;
      }
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi update bảo trì: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteViPham(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      await ApiRoutes.vipham.delete(id);
      ViPhamList.removeWhere((lp) => lp.maViPham == id);
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi delete bảo trì: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
