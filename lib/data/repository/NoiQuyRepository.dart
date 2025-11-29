
import 'package:flutter_application/data/model/NoiQuy.dart';
import 'package:flutter_application/data/service/NoiQuyService.dart';

class NoiQuyRepository {
 final service = NoiQuyService();

  Future<List<NoiQuy>> getAllNoiQuy() async {
    final res = await service.getAllNoiQuy();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => NoiQuy.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }
}
