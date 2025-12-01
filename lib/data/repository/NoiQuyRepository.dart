
import 'package:flutter_application/data/model/NoiQuy.dart';
import 'package:flutter_application/data/service/NoiQuyService.dart';

class NoiQuyRepository {
 final service = NoiQuyService();

  Future<List<NoiQuy>> getAllNoiQuy() async {
    final res = await service.getAllNoiQuy();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => NoiQuy.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<NoiQuy> createNoiQuy(Map<String, dynamic> data) async {
    final res = await service.create(data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return NoiQuy.fromJson(raw);
    } else {
      print("Dữ liệu trả về create không hợp lệ: $raw");
      throw Exception("Create Error");
    }
  }

  Future<NoiQuy> updateNoiQuy(int id, Map<String, dynamic> data) async {
    final res = await service.update(id, data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return NoiQuy.fromJson(raw);
    } else {
      print("Dữ liệu trả về update không hợp lệ: $raw");
      throw Exception("Update Error");
    }
  }

  Future<bool> deleteNoiQuy(int id) async {
    try {
      await service.delete(id);
      return true;
    } catch (e) {
      print("Lỗi khi xóa: $e");
      return false;
    }
  }
}
