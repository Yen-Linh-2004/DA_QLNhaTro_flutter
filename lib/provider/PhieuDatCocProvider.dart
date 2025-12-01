import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/PhieuDatCoc.dart';

class PhieuDatCocProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingdetail = false;
  List<PhieuDatCoc> PhieuDatCocList = [];
  PhieuDatCoc? PhieuDatCocDetail;

  Future<void> fetchPhieuDatCoc() async {
    try {
      isLoading = true;
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
        print("Dữ liệu PhieuDatCoc không hợp lệ");
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

  Future<void> createPhieuDatCoc(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.phieudatcoc.create(data);
      final newPhieuDatCoc = PhieuDatCoc.fromJson(response.data['data']);
      PhieuDatCocList.add(newPhieuDatCoc);

      print("Thêm data thành công: ${newPhieuDatCoc.maPhieuDatCoc}");
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi khi tạo data: $e");
      print("Stacktrace: $stacktrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPhieuDatCocById(int id) async {
    try {
      isLoading = true;
      notifyListeners();
      
      print("Bắt đầu fetch PhieuDatCoc với ID: $id");
      final response = await ApiRoutes.phieudatcoc.getPhieuDatCocId(id);
      print("Response status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode != 200) {
        print("API trả về lỗi: ${response.statusCode}");
        PhieuDatCocDetail = null;
        return;
      }

      final rawData = response.data['data'];
      print("Dữ liệu PhieuDatCoc: $rawData");

      if (rawData is Map) {
        PhieuDatCocDetail = PhieuDatCoc.fromJson(rawData as Map<String, dynamic>);
        print("Chuyển sang model: ${PhieuDatCocDetail?.toJson()}");
      } else if (rawData is List && rawData.isNotEmpty) {
        PhieuDatCocDetail = PhieuDatCoc.fromJson(rawData.first as Map<String, dynamic>);
        print("Chuyển sang model từ List: ${PhieuDatCocDetail?.toJson()}");
      } else {
        PhieuDatCocDetail = null;
        print("Dữ liệu PhieuDatCoc theo ID không hợp lệ");
      }

    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        print(" Lỗi server (500): ${e.response?.data}");
      } else {
        print(" Lỗi Dio khác: $e");
      }
      PhieuDatCocDetail = null;
    } catch (e, stacktrace) {
      print(" Lỗi fetchPhieuDatCocById: $e");
      print(stacktrace);
      PhieuDatCocDetail = null;
    } finally {
      isLoading = false;
      notifyListeners();
      print("⏹ Kết thúc fetch PhieuDatCocById, isLoading = $isLoading");
    }
  }

  Future<void> updatePhieuDatCoc(int id, Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.phieudatcoc.update(id, data);
      final updatedPhieuDatCoc = PhieuDatCoc.fromJson(response.data['data']);
      final index = PhieuDatCocList.indexWhere((lp) => lp.maPhieuDatCoc == id);
      if (index != -1) {
        PhieuDatCocList[index] = updatedPhieuDatCoc;
      }
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi update data: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePhieuDatCoc(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      await ApiRoutes.phieudatcoc.delete(id);
      PhieuDatCocList.removeWhere((lp) => lp.maPhieuDatCoc == id);
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
