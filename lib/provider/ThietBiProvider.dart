import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/ThietBi.dart';

class ThietBiProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingDetail = false;
  List<ThietBi> ThietBiList = [];
  ThietBi? ThietBiDetail;

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

  Future<void> fetchThietBiById(int id) async {
    try {
      isLoading = true;
      notifyListeners();
      
      print(" Bắt đầu fetch ThietBi với ID: $id");
      final response = await ApiRoutes.thietbi.getThietBiById(id);
      print("Response status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode != 200) {
        print("API trả về lỗi: ${response.statusCode}");
        ThietBiDetail = null;
        return;
      }

      final rawData = response.data['data'];
      print("Dữ liệu ThietBi: $rawData");
      // if (rawData is Map) {
      //   ThietBiDetail = ThietBi.fromJson(rawData as Map<String, dynamic>);
      //   print("Chuyển sang model: ${ThietBiDetail?.toJson()}");
      // } else if (rawData is List && rawData.isNotEmpty) {
      //   ThietBiDetail = ThietBi.fromJson(rawData.first as Map<String, dynamic>);
      //   print("Chuyển sang model từ List: ${ThietBiDetail?.toJson()}");
      // } else {
      //   ThietBiDetail = null;
      //   print("Dữ liệu ThietBi theo ID không hợp lệ");
      // }

    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        print(" Lỗi server (500): ${e.response?.data}");
      } else {
        print(" Lỗi Dio khác: $e");
      }
      ThietBiDetail = null;
    } catch (e, stacktrace) {
      print(" Lỗi fetchThietBiById: $e");
      print(stacktrace);
      ThietBiDetail = null;
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
