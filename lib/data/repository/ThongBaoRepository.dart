

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
}
