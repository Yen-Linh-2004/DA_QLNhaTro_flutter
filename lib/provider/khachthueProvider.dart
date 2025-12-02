import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/KhachThue.dart';

class KhachThueProvider extends ChangeNotifier {
  bool isLoading = false;
  List<KhachThue> khachThueList = [];
  KhachThue? khachThueDetail;

  Future<void> fetchKhachThue() async {
    try {
      isLoading = true;
      notifyListeners();

      final fullUrl =
          ApiRoutes.khachthue.dio.options.baseUrl + Endpoints.khachthue;
      print("Gọi API KhachThue: $fullUrl");

      final response = await ApiRoutes.khachthue.getAllKhachThue();

      // ==== LOG CHI TIẾT RESPONSE ====
      print("Status code: ${response.statusCode}");
      print("Raw response: ${response.data}");

      if (response.data == null || response.data['data'] == null) {
        print("API trả về NULL");
        khachThueList = [];
        return;
      }

      final rawData = response.data['data'];

      print("Dữ liệu KhachThue trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      if (rawData is List) {
        khachThueList =
            rawData.map((e) => KhachThue.fromJson(e)).toList();
        print("Parse List KhachThue: ${khachThueList.length} items");
      } else if (rawData is Map) {
        khachThueList = [KhachThue.fromJson(rawData as Map<String, dynamic>)];
        print("Parse Single KhachThue");
      } else {
        print("⚠ Dữ liệu không hợp lệ, không phải Map/List");
        khachThueList = [];
      }
    } on DioException catch (e) {
      final fullUrl =
          ApiRoutes.khachthue.dio.options.baseUrl + Endpoints.khachthue;

      print("LỖI DIO FETCH KHACHTHUE");
      print("URL: $fullUrl");
      print("Status code: ${e.response?.statusCode}");
      print("Response data: ${e.response?.data}");
      print("Headers: ${e.response?.headers}");

      khachThueList = [];
    } catch (e, stacktrace) {
      print("Lỗi không xác định: $e");
      print(stacktrace);
      khachThueList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchKhachThueById(int id) async {
    try {
      isLoading = true;
      notifyListeners();
      
      print(" Bắt đầu fetch KhachThue với ID: $id");
      final response = await ApiRoutes.khachthue.getById(id);
      print("Response status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode != 200) {
        print("API trả về lỗi: ${response.statusCode}");
        khachThueDetail = null;
        return;
      }

      final rawData = response.data['data'];
      print("Dữ liệu KhachThue thô: $rawData");

      if (rawData is Map) {
        khachThueDetail = KhachThue.fromJson(rawData as Map<String, dynamic>);
        print("Chuyển sang model: ${khachThueDetail?.toJson()}");
      } else if (rawData is List && rawData.isNotEmpty) {
        khachThueDetail = KhachThue.fromJson(rawData.first as Map<String, dynamic>);
        print("Chuyển sang model từ List: ${khachThueDetail?.toJson()}");
      } else {
        khachThueDetail = null;
        print("Dữ liệu KhachThue theo ID không hợp lệ");
      }

    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        print(" Lỗi server (500): ${e.response?.data}");
      } else {
        print(" Lỗi Dio khác: $e");
      }
      khachThueDetail = null;
    } catch (e, stacktrace) {
      print(" Lỗi fetchKhachThueById: $e");
      print(stacktrace);
      khachThueDetail = null;
    } finally {
      isLoading = false;
      notifyListeners();
      print("⏹ Kết thúc fetch KhachThueById, isLoading = $isLoading");
    }
  }

  Future<void> createKhachThue(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.khachthue.create(data);
      final newKhachThue = KhachThue.fromJson(response.data['data']);
      khachThueList.add(newKhachThue);

      print("Thêm dữ liệu thành công: ${newKhachThue.maKhachThue}");
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi khi tạo bảo trì: $e");
      print("Stacktrace: $stacktrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateKhachThue(int id, Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.khachthue.update(id, data);
      final updatedKhachThue = KhachThue.fromJson(response.data['data']);
      final index = khachThueList.indexWhere((lp) => lp.maKhachThue == id);
      if (index != -1) {
        khachThueList[index] = updatedKhachThue;
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

  Future<void> deleteKhachThue(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      await ApiRoutes.khachthue.delete(id);
      khachThueList.removeWhere((lp) => lp.maKhachThue == id);
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
