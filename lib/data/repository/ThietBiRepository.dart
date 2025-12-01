
import 'package:flutter_application/data/model/ThietBi.dart';
import 'package:flutter_application/data/service/ThietBiService.dart';

class ThietBiRepository {
 final service = ThietBiService();

  Future<List<ThietBi>> getAllThietBi() async {
    final res = await service.getAllThietBi();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => ThietBi.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<ThietBi?> getThietBiById(int id) async {
    try {
      final res = await service.getThietBiById(id);
      final data = res.data['data'];
      if (data != null && data is Map<String, dynamic>) {
        return ThietBi.fromJson(data);
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

  Future<ThietBi> createThietBi(Map<String, dynamic> data) async {
    final res = await service.create(data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return ThietBi.fromJson(raw);
    } else {
      print("Dữ liệu trả về create không hợp lệ: $raw");
      throw Exception("Create Error");
    }
  }

  Future<ThietBi> updateThietBi(int id, Map<String, dynamic> data) async {
    final res = await service.update(id, data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return ThietBi.fromJson(raw);
    } else {
      print("Dữ liệu trả về update không hợp lệ: $raw");
      throw Exception("Update Error");
    }
  }

  Future<bool> deleteThietBi(int id) async {
    try {
      await service.delete(id);
      return true;
    } catch (e) {
      print("Lỗi khi xóa: $e");
      return false;
    }
  }
}
