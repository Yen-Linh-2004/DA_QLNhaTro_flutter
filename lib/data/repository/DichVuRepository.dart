

import 'package:flutter_application/data/model/DichVu.dart';
import 'package:flutter_application/data/service/DichVuSerrvice.dart';

class DichVuRepository {
 final service = DichvuSerrvice();

  Future<List<DichVu>> getAllDichVu() async {
    final res = await service.getAllDichVu();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => DichVu.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }
}
