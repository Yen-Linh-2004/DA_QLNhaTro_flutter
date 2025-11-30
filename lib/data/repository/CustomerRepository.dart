
import 'package:flutter_application/data/model/Customer.dart';
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

  //   Future<List<HoaDonKhachThue>> getInvoiceLast() async {
  //   final res = await service.getInvoicelast();

  //   final data = res.data['data'];
  //   if (data is List) {
  //     return data
  //         .map((json) => HoaDonKhachThue.fromJson(json as Map<String, dynamic>))
  //         .toList();
  //   } else {
  //     print("Dữ liệu không phải List: $data");
  //     return [];
  //   }
  // }

}
