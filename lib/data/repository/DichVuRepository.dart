

import 'package:flutter_application/data/model/DichVu.dart';
import 'package:flutter_application/data/service/DichVuSerrvice.dart';

class DichVuRepository {
 final service = DichvuSerrvice();

  Future<List<DichVu>> getAllDichVu() async {
    final res = await service.getAllDichVu();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => DichVu.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<DichVu> createDichVu(Map<String, dynamic> data) async {
    final res = await service.create(data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return DichVu.fromJson(raw);
    } else {
      print("Dữ liệu trả về create không hợp lệ: $raw");
      throw Exception("Create Error");
    }
  }

  Future<DichVu> updateDichVu(int id, Map<String, dynamic> data) async {
    final res = await service.update(id, data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return DichVu.fromJson(raw);
    } else {
      print("Dữ liệu trả về update không hợp lệ: $raw");
      throw Exception("Update Error");
    }
  }

  Future<bool> deleteDichVu(int id) async {
    try {
      await service.delete(id);
      return true;
    } catch (e) {
      print("Lỗi khi xóa: $e");
      return false;
    }
  }
}
