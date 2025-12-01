import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/data/model/PhongTro.dart';

class PhongTroProvider extends ChangeNotifier {
  bool isLoadingList = false;
  bool isLoadingDetail = false;
  bool isLoading = false;

  List<PhongTro> PhongTroList = [];
  PhongTro? PhongTroDetail;

  // ------------------- FETCH DANH SÁCH -------------------
  Future<void> fetchPhongTro() async {
    isLoadingList = true;
    notifyListeners();

    try {
      final response = await ApiRoutes.phongtro.getAllPhongTro();

      dynamic data;
      if (response.data is String) {
        data = jsonDecode(response.data);
      } else {
        data = response.data;
      }

      if (data['data'] != null && data['data'] is List) {
        PhongTroList = (data['data'] as List)
            .map((e) => PhongTro.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        PhongTroList = [];
        print("Response không có key 'data' hoặc không phải List");
      }
    } catch (e, stacktrace) {
      print("Lỗi fetch PhongTro: $e");
      print(stacktrace);
      PhongTroList = [];
    } finally {
      isLoadingList = false;
      notifyListeners();
    }
  }

  // ------------------- FETCH PHÒNG TRỐNG -------------------
  Future<void> fetchPhongTrong() async {
    isLoadingList = true;
    notifyListeners();

    try {
      final response = await ApiRoutes.phongtro.getAllPhongTrong();
      final rawData = response.data['data'];

      if (rawData is List) {
        PhongTroList =
            rawData.map((e) => PhongTro.fromJson(e as Map<String, dynamic>)).toList();
      } else if (rawData is Map) {
        PhongTroList = [PhongTro.fromJson(rawData as Map<String, dynamic>)];
      } else {
        PhongTroList = [];
        print("Dữ liệu PhongTrong không hợp lệ");
      }
    } catch (e, stacktrace) {
      print("Lỗi fetch PhongTrong: $e");
      print(stacktrace);
      PhongTroList = [];
    } finally {
      isLoadingList = false;
      notifyListeners();
    }
  }

  // ------------------- FETCH CHI TIẾT -------------------
  Future<void> fetchPhongTroById(int id) async {
    isLoadingDetail = true;
    notifyListeners();
    try {
      final response = await ApiRoutes.phongtro.getPhongTroById(id);
      if (response.statusCode != 200) {
        PhongTroDetail = null;
        return;
      }
      final rawData = response.data['data'];
      if (rawData is Map) {
        PhongTroDetail = PhongTro.fromJson(rawData as Map<String, dynamic>);
      } else if (rawData is List && rawData.isNotEmpty) {
        PhongTroDetail = PhongTro.fromJson(rawData.first);
      } else {
        PhongTroDetail = null;
      }
    } catch (e, stacktrace) {
      print("Lỗi fetchPhongTroById: $e");
      print(stacktrace);
      PhongTroDetail = null;
    } finally {
      isLoadingDetail = false;
      notifyListeners();
    }
  }

  Future<bool> createPhongTro(Map<String, dynamic> data) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiRoutes.phongtro.create(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final rawData = response.data['data'];
        if (rawData != null && rawData is Map) {
          PhongTro newRoom = PhongTro.fromJson(rawData as Map<String, dynamic>);
          PhongTroList.add(newRoom);
          notifyListeners();
        }
        return true;
      } else {
        print("Lỗi tạo phòng, status code: ${response.statusCode}");
        return false;
      }
    } on DioException catch (e) {
      print("Lỗi Dio khi tạo phòng: $e");
      return false;
    } catch (e, stacktrace) {
      print("Lỗi không xác định khi tạo phòng: $e");
      print(stacktrace);
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
