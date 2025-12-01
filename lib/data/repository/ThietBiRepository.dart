
import 'package:flutter_application/data/model/ThietBi.dart';
import 'package:flutter_application/data/service/ThietBiService.dart';

class ThietBiRepository {
 final service = ThietBiService();

  /// Lấy toàn bộ danh sách phòng trọ
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
