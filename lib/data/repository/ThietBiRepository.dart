
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
}
