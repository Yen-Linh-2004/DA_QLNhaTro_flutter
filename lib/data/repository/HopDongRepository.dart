
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
}
