
import 'package:flutter_application/data/model/ViPham.dart';
import 'package:flutter_application/data/service/ViPhamService.dart';

class ViPhamRepository {
 final service = ViPhamService();

  /// Lấy toàn bộ danh sách phòng trọ
  Future<List<ViPham>> getAllViPham() async {
    final res = await service.getAllViPham();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => ViPham.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<ViPham> createViPham(Map<String, dynamic> data) async {
    final res = await service.create(data);
    final raw = res.data['data'];
    if (raw is Map<String, dynamic>) {
      return ViPham.fromJson(raw);
    } else {
      print("Dữ liệu trả về create không hợp lệ: $raw");
      throw Exception("Create Error");
    }
  }

  Future<ViPham> updateViPham(int id, Map<String, dynamic> data) async {
    final res = await service.update(id, data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return ViPham.fromJson(raw);
    } else {
      print("Dữ liệu trả về update không hợp lệ: $raw");
      throw Exception("Update Error");
    }
  }

  Future<bool> deleteViPham(int id) async {
    try {
      await service.delete(id);
      return true;
    } catch (e) {
      print("Lỗi khi xóa: $e");
      return false;
    }
  }
}
