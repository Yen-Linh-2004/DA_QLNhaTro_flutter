
import 'package:flutter_application/data/model/YeuCauBaoTri.dart';
import 'package:flutter_application/data/service/BaoTriService.dart';

class BaoTriRepository {
 final service = BaoTriService();

  Future<List<YeuCauBaoTri>> getAllBaoTri() async {
    final res = await service.getAllBaoTri();
    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => YeuCauBaoTri.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }
}
