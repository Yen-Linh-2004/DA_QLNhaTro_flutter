import 'package:flutter_application/data/model/Khachthue.dart';
import 'package:flutter_application/data/service/khachThueService.dart';

class KhachThueRepository {
 final service = KhachThueService();

  Future<List<KhachThue>> getAllKhachThue() async {
    final res = await service.getAllKhachThue();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => KhachThue.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu Khách thuê không phải List: $data");
      return [];
    }
  }

  Future<KhachThue?> getKhachThueById(int id) async {
    try {
      final res = await service.getById(id);

      final data = res.data['data'];

      if (data != null && data is Map<String, dynamic>) {
        return KhachThue.fromJson(data);
      } else {
        print("Dữ liệu Khách thuê theo ID null hoặc không hợp lệ: $data");
        return null; 
      }
    } catch (e, stacktrace) {
      print("Lỗi khi lấy Khách thuê theo ID: $e");
      print(stacktrace);
      return null;
    }
  }

  Future<KhachThue> createKhachThue(Map<String, dynamic> data) async {
    final res = await service.create(data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return KhachThue.fromJson(raw);
    } else {
      print("Dữ liệu trả về create không hợp lệ: $raw");
      throw Exception("Create Error");
    }
  }

  Future<KhachThue> updateKhachThue(int id, Map<String, dynamic> data) async {
    final res = await service.update(id, data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return KhachThue.fromJson(raw);
    } else {
      print("Dữ liệu trả về update không hợp lệ: $raw");
      throw Exception("Update Error");
    }
  }

  Future<bool> deleteKhachThue(int id) async {
    try {
      await service.delete(id);
      return true;
    } catch (e) {
      print("Lỗi khi xóa: $e");
      return false;
    }
  }
}
