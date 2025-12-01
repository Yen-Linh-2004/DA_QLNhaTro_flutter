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
        print("Dữ liệu BaoTri không hợp lệ");
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

  Future<void> createBaoTri(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.baotri.create(data);
      final newBaoTri = YeuCauBaoTri.fromJson(response.data['data']);
      BaoTriList.add(newBaoTri);

      print("Thêm bảo trì thành công: ${newBaoTri.tenantName}");
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi khi tạo bảo trì: $e");
      print("Stacktrace: $stacktrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateBaoTri(int id, Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.baotri.update(id, data);
      final updatedBaoTri = YeuCauBaoTri.fromJson(response.data['data']);
      final index = BaoTriList.indexWhere((lp) => lp.id == id);
      if (index != -1) {
        BaoTriList[index] = updatedBaoTri;
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

  Future<void> deleteBaoTri(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      await ApiRoutes.baotri.delete(id);
      BaoTriList.removeWhere((lp) => lp.id == id);
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
