import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/DichVu.dart';

class DichVuProvider extends ChangeNotifier {
  bool isLoading = false;
  List<DichVu> DichVuList = [];

  Future<void> fetchDichVu() async {
    try {
      isLoading = true;
      notifyListeners();
      isLoading = false;
      notifyListeners();

      final fullUrl = ApiRoutes.dichvu.dio.options.baseUrl + Endpoints.dichvu;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.dichvu.getAllDichVu();
      final rawData = response.data['data']; 

      print("Dữ liệu DichVu trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      if (rawData is List) {
        DichVuList = rawData
            .map((e) => DichVu.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        DichVuList = [DichVu.fromJson(rawData as Map<String, dynamic>)];
      } else {
        DichVuList = [];
        print("Dữ liệu DichVu không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.dichvu.dio.options.baseUrl + Endpoints.dichvu;
      print("Gọi API DichVu: $fullUrl");
      print("Lỗi fetch DichVu: $e");
      print(stacktrace);
      DichVuList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createDichVu(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.dichvu.create(data);
      final newDichVu = DichVu.fromJson(response.data['data']);
      DichVuList.add(newDichVu);

      print("Thêm data thành công: ${newDichVu.tenDichVu}");
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi khi tạo data: $e");
      print("Stacktrace: $stacktrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateDichVu(int id, Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.dichvu.update(id, data);
      final updatedDichVu = DichVu.fromJson(response.data['data']);
      final index = DichVuList.indexWhere((lp) => lp.maDichVu == id);
      if (index != -1) {
        DichVuList[index] = updatedDichVu;
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

  Future<void> deleteDichVu(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      await ApiRoutes.dichvu.delete(id);
      DichVuList.removeWhere((lp) => lp.maDichVu == id);
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
