

import 'package:flutter_application/data/model/PhieuDatCoc.dart';
import 'package:flutter_application/data/service/PhieuDatCocService.dart';
class PhieuDatCocRepository {
 final service = PhieuDatCocSerrvice();

  Future<List<PhieuDatCoc>> getAllPhieuDatCoc() async {
    final res = await service.getAllPhieuDatCoc();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => PhieuDatCoc.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }
}
