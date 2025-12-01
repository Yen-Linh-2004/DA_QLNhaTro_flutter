
import 'package:flutter_application/data/model/HopDong.dart';
import 'package:flutter_application/data/service/HopDongService.dart';

class HopDongRepository {
 final service = HopDongSerrvice();

  Future<List<HopDong>> getAllHopDong() async {
    final res = await service.getAllHopDong();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => HopDong.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

    Future<HopDong?> getHopDongById(int id) async {
    try {
      final res = await service.getHopDongId(id);

      final data = res.data['data'];

      if (data != null && data is Map<String, dynamic>) {
        return HopDong.fromJson(data);
      } else {
        print("Dữ liệu hợp đồng theo ID null hoặc không hợp lệ: $data");
        return null; 
      }
    } catch (e, stacktrace) {
      print("Lỗi khi lấy hợp đồng theo ID: $e");
      print(stacktrace);
      return null;
    }
  }

  Future<HopDong> createHopDong(Map<String, dynamic> data) async {
    final res = await service.create(data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return HopDong.fromJson(raw);
    } else {
      print("Dữ liệu trả về create không hợp lệ: $raw");
      throw Exception("Create Error");
    }
  }

  Future<HopDong> updateHopDong(int id, Map<String, dynamic> data) async {
    final res = await service.update(id, data);

    final raw = res.data['data'];

    if (raw is Map<String, dynamic>) {
      return HopDong.fromJson(raw);
    } else {
      print("Dữ liệu trả về update không hợp lệ: $raw");
      throw Exception("Update Error");
    }
  }

  Future<bool> deleteHopDong(int id) async {
    try {
      await service.delete(id);
      return true;
    } catch (e) {
      print("Lỗi khi xóa: $e");
      return false;
    }
  }
}
