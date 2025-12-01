import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/NoiQuy.dart';

class NoiQuyProvider extends ChangeNotifier {
  bool isLoading = false;
  List<NoiQuy> NoiQuyList = [];

  Future<void> fetchNoiQuy() async {
    isLoading = true;
    notifyListeners();

    try {
      final fullUrl = ApiRoutes.noiquy.dio.options.baseUrl + Endpoints.noiquy;
      print("Gọi API: $fullUrl");

      final response = await ApiRoutes.noiquy.getAllNoiQuy();
      final rawData = response.data['data'];

      print("Dữ liệu NoiQuy trả về: $rawData");

      // Parse an toàn
      if (rawData is List) {
        NoiQuyList = rawData
            .map((e) => NoiQuy.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        NoiQuyList = [NoiQuy.fromJson(rawData as Map<String, dynamic>)];
      } else {
        NoiQuyList = [];
        print("Dữ liệu NoiQuy không hợp lệ");
      }
    } catch (e, stacktrace) {
      print("Lỗi fetch NoiQuy: $e");
      print(stacktrace);
      NoiQuyList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createNoiQuy(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.noiquy.create(data);
      final newNoiQuy = NoiQuy.fromJson(response.data['data']);
      NoiQuyList.add(newNoiQuy);

      print("Thêm nội quy thành công: ${newNoiQuy.tieuDe}");
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi khi tạo nội quy: $e");
      print("Stacktrace: $stacktrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateNoiQuy(int id, Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await ApiRoutes.noiquy.update(id, data);
      final updatedNoiQuy = NoiQuy.fromJson(response.data['data']);
      final index = NoiQuyList.indexWhere((lp) => lp.maNoiQuy == id);
      if (index != -1) {
        NoiQuyList[index] = updatedNoiQuy;
      }
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi update nội quy: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteNoiQuy(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      await ApiRoutes.noiquy.delete(id);
      NoiQuyList.removeWhere((lp) => lp.maNoiQuy == id);
      notifyListeners();
    } catch (e, stacktrace) {
      print("Lỗi delete nội quy: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
