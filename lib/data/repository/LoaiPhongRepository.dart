

import 'package:flutter_application/data/model/LoaiPhong.dart';
import 'package:flutter_application/data/service/LoaiPhongService.dart';

class LoaiPhongRepository {
  final service = LoaiPhongService();

  Future<List<LoaiPhong>> getAll() async {
    final res = await service.getAll();
    List data = res.data['data']; 
    return data.map((json) => LoaiPhong.fromJson(json)).toList();
  }

  Future<LoaiPhong> getById(int id) async {
    final res = await service.getById(id);
    return LoaiPhong.fromJson(res.data['data']);
  }

  Future<LoaiPhong> create(LoaiPhong item) async {
    final res = await service.create(item.toJson());
    return LoaiPhong.fromJson(res.data['data']);
  }

  Future<LoaiPhong> update(int id, LoaiPhong item) async {
    final res = await service.update(id, item.toJson());
    return LoaiPhong.fromJson(res.data['data']);
  }

  Future<bool> delete(int id) async {
    await service.delete(id);
    return true;
  }
}
