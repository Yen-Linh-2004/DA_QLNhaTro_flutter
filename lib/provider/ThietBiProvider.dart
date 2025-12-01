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
        print("Dữ liệu ThietBi không hợp lệ");
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

  Future<void> createThietBi(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.thietbi.create(data);
      final newThietBi = ThietBi.fromJson(response.data['data']);
      ThietBiList.add(newThietBi);

      print("Thêm thiết bị thành công: ${newThietBi.tenThietBi}");
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi khi tạo thiết bị: $e");
      print("Stacktrace: $stacktrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateThietBi(int id, Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.thietbi.update(id, data);
      final updatedThietBi = ThietBi.fromJson(response.data['data']);
      final index = ThietBiList.indexWhere((lp) => lp.maThietBi == id);
      if (index != -1) {
        ThietBiList[index] = updatedThietBi;
      }
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi update thiết bị: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteThietBi(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      await ApiRoutes.thietbi.delete(id);
      ThietBiList.removeWhere((lp) => lp.maThietBi == id);
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi delete thiết bị: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
