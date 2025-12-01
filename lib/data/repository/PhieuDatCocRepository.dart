

import 'package:flutter_application/data/model/PhieuDatCoc.dart';
import 'package:flutter_application/data/service/PhieuDatCocService.dart';
class PhieuDatCocRepository {
 final service = PhieuDatCocSerrvice();

  Future<List<PhieuDatCoc>> getAllPhieuDatCoc() async {
    final res = await service.getAllPhieuDatCoc();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => PhieuDatCoc.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

    Future<PhieuDatCoc?> getKhachThueById(int id) async {
    try {
      final res = await service.getPhieuDatCocId(id);

      final data = res.data['data'];

      if (data != null && data is Map<String, dynamic>) {
        return PhieuDatCoc.fromJson(data);
      } else {
        print("Dữ liệu theo ID null hoặc không hợp lệ: $data");
        return null; 
      }
    } catch (e, stacktrace) {
      print("Lỗi khi lấy dứ liệu theo ID: $e");
      print(stacktrace);
      return null;
    }
  }

  Future<PhieuDatCoc> createPhieuDatCoc(Map<String, dynamic> data) async {
    final res = await service.create(data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return PhieuDatCoc.fromJson(raw);
    } else {
      print("Dữ liệu trả về create không hợp lệ: $raw");
      throw Exception("Create Error");
    }
  }

  Future<PhieuDatCoc> updatePhieuDatCoc(int id, Map<String, dynamic> data) async {
    final res = await service.update(id, data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return PhieuDatCoc.fromJson(raw);
    } else {
      print("Dữ liệu trả về update không hợp lệ: $raw");
      throw Exception("Update Error");
    }
  }

  Future<bool> deletePhieuDatCoc(int id) async {
    try {
      await service.delete(id);
      return true;
    } catch (e) {
      print("Lỗi khi xóa: $e");
      return false;
    }
  }
}
