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
        print("⚠️ Dữ liệu NoiQuy không hợp lệ");
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
}
