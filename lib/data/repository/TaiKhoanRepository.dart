

import 'package:flutter_application/data/model/TaiKhoan.dart';
import 'package:flutter_application/data/service/TaiKhoanService.dart';
class TaiKhoanRepository {
 final service = TaiKhoanSerrvice();

  Future<List<TaiKhoan>> getAllTaiKhoan() async {
    final res = await service.getAllTaiKhoan();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => TaiKhoan.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }
}
