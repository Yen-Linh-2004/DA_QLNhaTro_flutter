import 'package:flutter_application/data/model/Khachthue.dart';
import 'package:flutter_application/data/service/khachThueService.dart';

class KhachThueRepository {
 final service = KhachThueService();

  /// Lấy toàn bộ danh sách khách thuê
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

  /// Lấy khách thuê theo ID
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

}
