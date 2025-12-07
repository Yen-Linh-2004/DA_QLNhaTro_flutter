import 'package:dio/dio.dart';
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
      if (response.data == null || response.data['data'] == null) {
        print("⚠ Backend không trả về trường 'data'");
        return;
      }
      final newLoaiPhong = LoaiPhong.fromJson(response.data['data']);
      loaiPhongList.add(newLoaiPhong);
      print("Thêm loại phòng thành công: ${newLoaiPhong.tenLoaiPhong}");
      notifyListeners();
    } on DioException catch (e) {
      print("Lỗi Dio (tạo loại phòng): ${e.response?.data}");
    } catch (e, stacktrace) {
      print("Lỗi không xác định: $e");
      print("Stacktrace: $stacktrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

Future<void> updateLoaiPhong(int maLoaiPhong, Map<String, dynamic> payload) async {
  try {
    isLoading = true;
    notifyListeners();

    print('[UPDATE] payload: $payload');

    final response = await ApiRoutes.loaiPhong.update(maLoaiPhong, payload);

    final updated = LoaiPhong.fromJson(response.data['data']); // <- đây là điểm fix

    final idx = loaiPhongList.indexWhere((e) => e.maLoaiPhong == maLoaiPhong);

    if (idx != -1) {
      loaiPhongList[idx] = updated;
    } else {
      // chỉ add nếu thật sự mới
      loaiPhongList.add(updated);
    }

    print('[UPDATE] success');
    notifyListeners();

  } on DioError catch (e) {
    print('[UPDATE] DioError status: ${e.response?.statusCode}');
    print('[UPDATE] DioError data: ${e.response?.data}');
    throw e.response?.data ?? {'message': 'Lỗi không xác định'};
  } catch (e, st) {
    print('[UPDATE] error: $e');
    print(st);
    rethrow;
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

Future<bool> deleteLoaiPhong(int maLoaiPhong) async {
  isLoading = true;
  notifyListeners();

  try {
    await ApiRoutes.loaiPhong.delete(maLoaiPhong);

    loaiPhongList.removeWhere((lp) => lp.maLoaiPhong == maLoaiPhong);

    return true;   // Thành công
  } catch (e, s) {
    print("Lỗi delete loại phòng: $e");
    print(s);
    return false;  // Thất bại
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

}
