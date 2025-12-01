import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/DichVu.dart';

class DichVuProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingdetail = false;
  List<DichVu> DichVuList = [];
  DichVu? DichVuDetail;

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

  Future<void> fetchDichVuById(int id) async {
    try {
      isLoading = true;
      notifyListeners();
      
      print(" Bắt đầu fetch DichVu với ID: $id");
      final response = await ApiRoutes.dichvu.getDichVuById(id);
      print("Response status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode != 200) {
        print("API trả về lỗi: ${response.statusCode}");
        DichVuDetail = null;
        return;
      }

      final rawData = response.data['data'];
      print("Dữ liệu DichVu thô: $rawData");

      if (rawData is Map) {
        DichVuDetail = DichVu.fromJson(rawData as Map<String, dynamic>);
        print("Chuyển sang model: ${DichVuDetail?.toJson()}");
      } else if (rawData is List && rawData.isNotEmpty) {
        DichVuDetail = DichVu.fromJson(rawData.first as Map<String, dynamic>);
        print("Chuyển sang model từ List: ${DichVuDetail?.toJson()}");
      } else {
        DichVuDetail = null;
        print("Dữ liệu DichVu theo ID không hợp lệ");
      }

    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        print(" Lỗi server (500): ${e.response?.data}");
      } else {
        print(" Lỗi Dio khác: $e");
      }
      DichVuDetail = null;
    } catch (e, stacktrace) {
      print(" Lỗi fetchDichVuById: $e");
      print(stacktrace);
      DichVuDetail = null;
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
