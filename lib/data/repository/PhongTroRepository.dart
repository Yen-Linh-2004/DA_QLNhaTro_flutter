import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/PhongTro.dart';
import 'package:flutter_application/data/service/PhongTroService.dart';

class PhongtroRepository {
 final service = PhongtroService();

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

  Future<PhongTro?> getPhongTroById(int id) async {
    try {
      final res = await service.getPhongTroById(id);

      final data = res.data['data'];

      if (data != null && data is Map<String, dynamic>) {
        return PhongTro.fromJson(data);
      } else {
        print("Dữ liệu phòng trọ theo ID null hoặc không hợp lệ: $data");
        return null; 
      }
    } catch (e, stacktrace) {
      print("Lỗi khi lấy phòng trọ theo ID: $e");
      print(stacktrace);
      return null;
    }
  }

  Future<PhongTro> create(Map<String, dynamic> data) async {
    try {
      final res = await service.create(data);
      return PhongTro.fromJson(res.data['data']);
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<PhongTro> update(int id, Map<String, dynamic> data) async {
    final res = await service.update(id, data);
    return PhongTro.fromJson(res.data['data']);
  }

  Future<bool> delete(int id) async {
    await service.delete(id);
    return true;
  }

  Future<PhongTro?> getPhongTrongById(int id) async {
    try {
      final response = await service.getPhongTrongById(id);

      if (response.statusCode != 200) {
        return null;
      }

      final rawData = response.data['data'];

      if (rawData is Map<String, dynamic>) {
        return PhongTro.fromJson(rawData);
      }

      if (rawData is List && rawData.isNotEmpty) {
        return PhongTro.fromJson(
            rawData.first as Map<String, dynamic>);
      }

      return null;
    } catch (e) {
      print("Repository Error (getPhongTrongById): $e");
      return null;
    }
  }
}
