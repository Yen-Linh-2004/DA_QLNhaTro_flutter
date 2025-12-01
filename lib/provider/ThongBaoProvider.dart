import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/ThongBao.dart';

class ThongBaoProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ThongBao> ThongBaoList = [];

  Future<void> fetchThongBao() async {
    try {
      isLoading = true;
      notifyListeners();

      final fullUrl = ApiRoutes.thongbao.dio.options.baseUrl + Endpoints.thongbao;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.thongbao.getAllThongBao();
      final rawData = response.data['data']; 

      print("Dữ liệu ThongBao trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      // --- Parse an toàn: list hoặc object ---
      if (rawData is List) {
        ThongBaoList = rawData
            .map((e) => ThongBao.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        ThongBaoList = [ThongBao.fromJson(rawData as Map<String, dynamic>)];
      } else {
        ThongBaoList = [];
        print("Dữ liệu ThongBao không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.thongbao.dio.options.baseUrl + Endpoints.thongbao;
      print("Gọi API ThongBao: $fullUrl");
      print("Lỗi fetch ThongBao: $e");
      print(stacktrace);
      ThongBaoList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchThongBaoHeThong() async {
    try {
      isLoading = true;
      notifyListeners();

      final fullUrl = ApiRoutes.thongbao.dio.options.baseUrl + Endpoints.thongbaohethong;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.thongbao.getAllThongBaoHeThong();
      final rawData = response.data['data']; 

      print("Dữ liệu ThongBao trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      // --- Parse an toàn: list hoặc object ---
      if (rawData is List) {
        ThongBaoList = rawData
            .map((e) => ThongBao.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        ThongBaoList = [ThongBao.fromJson(rawData as Map<String, dynamic>)];
      } else {
        ThongBaoList = [];
        print("Dữ liệu ThongBao không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.thongbao.dio.options.baseUrl + Endpoints.thongbaohethong;
      print("Gọi API ThongBao: $fullUrl");
      print("Lỗi fetch ThongBao: $e");
      print(stacktrace);
      ThongBaoList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createThongBao(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.thongbao.create(data);
      final newThongBao = ThongBao.fromJson(response.data['data']);
      ThongBaoList.add(newThongBao);

      print("Thêm thông báo thành công: ${newThongBao.tieuDe}");
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi khi tạo thông báo: $e");
      print("Stacktrace: $stacktrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateThongBao(int id, Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.thongbao.update(id, data);
      final updatedThongBao = ThongBao.fromJson(response.data['data']);
      final index = ThongBaoList.indexWhere((lp) => lp.maThongBao == id);
      if (index != -1) {
        ThongBaoList[index] = updatedThongBao;
      }
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi update thông báo: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteThongBao(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      await ApiRoutes.thongbao.delete(id);
      ThongBaoList.removeWhere((lp) => lp.maThongBao == id);
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi delete thông báo: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
