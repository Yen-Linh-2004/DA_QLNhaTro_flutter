
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

}
