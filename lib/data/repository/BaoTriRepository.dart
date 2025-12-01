
import 'package:flutter_application/data/model/YeuCauBaoTri.dart';
import 'package:flutter_application/data/service/BaoTriService.dart';

class BaoTriRepository {
 final service = BaoTriService();

  Future<List<YeuCauBaoTri>> getAllBaoTri() async {
    final res = await service.getAllBaoTri();
    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => YeuCauBaoTri.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<YeuCauBaoTri> createBaoTri(Map<String, dynamic> data) async {
    final res = await service.create(data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return YeuCauBaoTri.fromJson(raw);
    } else {
      print("Dữ liệu trả về create không hợp lệ: $raw");
      throw Exception("Create Error");
    }
  }

  Future<YeuCauBaoTri> updateBaoTri(int id, Map<String, dynamic> data) async {
    final res = await service.update(id, data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return YeuCauBaoTri.fromJson(raw);
    } else {
      print("Dữ liệu trả về update không hợp lệ: $raw");
      throw Exception("Update Error");
    }
  }

  Future<bool> deleteBaoTri(int id) async {
    try {
      await service.delete(id);
      return true;
    } catch (e) {
      print("Lỗi khi xóa: $e");
      return false;
    }
  }
}
