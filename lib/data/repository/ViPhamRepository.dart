
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
}
