import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/Customer.dart';

class CustomerProvider extends ChangeNotifier {
  bool isLoading = false;
  List<HoaDonKhachThue> InvoicesList = [];

  Future<void> fetchInvoice() async {
    try {
      isLoading = true;
      notifyListeners();
      isLoading = false;
      notifyListeners();

      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.invoices;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.customer.getInvoice();
      final rawData = response.data['data']; 

      print("Dữ liệu hóa đơn trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");
      
      if (rawData is List) {
        InvoicesList = rawData
            .map((e) => HoaDonKhachThue.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        InvoicesList = [HoaDonKhachThue.fromJson(rawData as Map<String, dynamic>)];
      } else {
        InvoicesList = [];
        print("⚠️ Dữ liệu hóa đơn không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.invoices;
      print("Gọi API hóa đơn: $fullUrl");
      print("Lỗi fetch hóa đơn: $e");
      print(stacktrace);
      InvoicesList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchInvoiceLast() async {
    try {
      isLoading = true;
      notifyListeners();
      
      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.invoiceslast;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.customer.getInvoicelast();
      final rawData = response.data['data']; 

      print("Dữ liệu hóa đơn trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      if (rawData is List) {
        InvoicesList = rawData
            .map((e) => HoaDonKhachThue.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        InvoicesList = [HoaDonKhachThue.fromJson(rawData as Map<String, dynamic>)];
      } else {
        InvoicesList = [];
        print("⚠️ Dữ liệu hóa đơn không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.invoiceslast;
      print("Gọi API hóa đơn: $fullUrl");
      print("Lỗi fetch hóa đơn: $e");
      print(stacktrace);
      InvoicesList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
