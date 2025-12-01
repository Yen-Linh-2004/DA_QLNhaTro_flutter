
import 'package:flutter_application/data/model/LoaiPhong.dart';
import 'package:flutter_application/data/service/LoaiPhongService.dart';

class LoaiPhongRepository {
  final service = LoaiPhongService();

  Future<List<LoaiPhong>> getAll() async {
    final res = await service.getAll();
    List data = res.data['data']; 
    return data.map((json) => LoaiPhong.fromJson(json)).toList();
  }
  
  Future<LoaiPhong> create(Map<String, dynamic> data) async {
    final res = await service.create(data);
    return LoaiPhong.fromJson(res.data['data']);
  }

  // Cập nhật LoaiPhong
  Future<LoaiPhong> update(int id, Map<String, dynamic> data) async {
    final res = await service.update(id, data);
    return LoaiPhong.fromJson(res.data['data']);
  }

  // Xóa LoaiPhong
  Future<bool> delete(int id) async {
    await service.delete(id);
    return true;
  }
}
