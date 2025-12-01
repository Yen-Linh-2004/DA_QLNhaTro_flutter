
import 'package:flutter_application/data/model/PhongTro.dart';
import 'package:flutter_application/data/service/PhongTroService.dart';

class PhongtroRepository {
 final service = PhongtroService();

  /// Lấy toàn bộ danh sách phòng trọ
  Future<List<PhongTro>> getAllPhongTro() async {
    final res = await service.getAllPhongTro();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => PhongTro.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<List<PhongTro>> getAllPhongTrong() async {
    final res = await service.getAllPhongTrong();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => PhongTro.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<PhongTro?> getKhachThueById(int id) async {
    try {
      final res = await service.getPhongTroById(id);

      final data = res.data['data'];

      if (data != null && data is Map<String, dynamic>) {
        return PhongTro.fromJson(data);
      } else {
        print("Dữ liệu phòng trọ theo ID null hoặc không hợp lệ: $data");
        return null; 
      }
    } catch (e, stacktrace) {
      print("Lỗi khi lấy phòng trọ theo ID: $e");
      print(stacktrace);
      return null;
    }
  }

  Future<PhongTro> createPhongTro(Map<String, dynamic> data) async {
    final res = await service.create(data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return PhongTro.fromJson(raw);
    } else {
      print("Dữ liệu trả về create không hợp lệ: $raw");
      throw Exception("Create Error");
    }
  }

  Future<PhongTro> updatePhongTro(int id, Map<String, dynamic> data) async {
    final res = await service.update(id, data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return PhongTro.fromJson(raw);
    } else {
      print("Dữ liệu trả về update không hợp lệ: $raw");
      throw Exception("Update Error");
    }
  }

  Future<bool> deletePhongTro(int id) async {
    try {
      await service.delete(id);
      return true;
    } catch (e) {
      print("Lỗi khi xóa: $e");
      return false;
    }
  }
}
