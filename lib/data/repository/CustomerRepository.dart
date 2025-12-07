
import 'package:dio/dio.dart';
import 'package:flutter_application/data/model/Customer.dart';
import 'package:flutter_application/data/model/YeuCauBaoTri.dart';
import 'package:flutter_application/data/service/CustomerService.dart';

class CustomerRepository {
 final service = CustomerSerrvice();

  Future<List<HoaDonKhachThue>> getInvoice() async {
    final res = await service.getInvoice();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => HoaDonKhachThue.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<List<HoaDonKhachThue>> getInvoiceLast() async {
    final res = await service.getInvoicelast();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => HoaDonKhachThue.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<List<HoaDonKhachThue>> getIRoomStatus() async {
    final res = await service.getRoomStatus();
    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => HoaDonKhachThue.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<List<ViPhamKhachThue>> getCustomerViolations() async {
    final res = await service.getCustomerViolations();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => ViPhamKhachThue.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<ViPhamKhachThue> create(Map<String, dynamic> data) async {
    try {
      final res = await service.createViolations(data);
      return ViPhamKhachThue.fromJson(res.data['data']);
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<List<YeuCauSuaChuaKhachThue>> getMaintainerRequest() async {
    final res = await service.getMaintenanceRequest();

    final data = res.data['data'];
    if (data is List) {
      return data
          .map((json) => YeuCauSuaChuaKhachThue.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      print("Dữ liệu không phải List: $data");
      return [];
    }
  }

  Future<YeuCauSuaChuaKhachThue?> getMaintainerRequestById(int id) async {
    try {
      final res = await service.getMaintenanceRequestById(id);
      final data = res.data['data'];
      if (data != null && data is Map<String, dynamic>) {
        return YeuCauSuaChuaKhachThue.fromJson(data);
      } else {
        print("Dữ liệu yêu cầu sửa chữa theo ID null hoặc không hợp lệ: $data");
        return null; 
      }
    } catch (e, stacktrace) {
      print("Lỗi khi lấy yêu cầu sửa chữa theo ID: $e");
      print(stacktrace);
      return null;
    }
  }
}
