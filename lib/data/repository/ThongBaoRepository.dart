

import 'package:flutter_application/data/model/ThongBao.dart';
import 'package:flutter_application/data/service/ThongBaoService.dart';

class ThongBaoRepository {
 final service = ThongBaoSerrvice();

  Future<List<ThongBao>> getAllThongBao() async {
    final res = await service.getAllThongBao();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => ThongBao.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<List<ThongBao>> getThongBaoHeThong() async {
    final res = await service.getAllThongBaoHeThong();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => ThongBao.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<ThongBao> createThongBao(Map<String, dynamic> data) async {
    final res = await service.create(data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return ThongBao.fromJson(raw);
    } else {
      print("Dữ liệu trả về create không hợp lệ: $raw");
      throw Exception("Create Error");
    }
  }

  Future<ThongBao> updateThongBao(int id, Map<String, dynamic> data) async {
    final res = await service.update(id, data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return ThongBao.fromJson(raw);
    } else {
      print("Dữ liệu trả về update không hợp lệ: $raw");
      throw Exception("Update Error");
    }
  }

  Future<bool> deleteThongBao(int id) async {
    try {
      await service.delete(id);
      return true;
    } catch (e) {
      print("Lỗi khi xóa: $e");
      return false;
    }
  }
}
