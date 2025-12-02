import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/Customer.dart';
import 'package:flutter_application/data/model/DangKyDichVu.dart';
import 'package:flutter_application/data/model/KhachThue.dart';
import 'package:flutter_application/data/model/ThietBi.dart';

class CustomerProvider extends ChangeNotifier {
  bool isLoading = false;
  List<HoaDonKhachThue> InvoicesList = [];
  List<ThongTinHopDong> ContactList = [];
  List<ThongTinPhong> RoomList = [];
  List<ThietBi> ThietBiList = [];
  List<KhachThue> DSKhachThue = [];
  List<DichVuDangKy> DichVuList = [];
  ThongTinHopDong? HopDongList;
  List<RoomData> roomList = [];
  
  Future<void> fetchInvoice() async {
    try {
      isLoading = true;
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
        print("Dữ liệu hóa đơn không hợp lệ");
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
        print("Dữ liệu hóa đơn không hợp lệ");
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

  Future<void> fetchContactInfo() async {
    try {
      isLoading = true;
      notifyListeners();
      
      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.contract;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.customer.getContractInfo();
      final rawData = response.data['data']; 

      print("Dữ liệu hợp đồng trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      if (rawData is List) {
        ContactList = rawData
            .map((e) => ThongTinHopDong.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        ContactList = [ThongTinHopDong.fromJson(rawData as Map<String, dynamic>)];
      } else {
        ContactList = [];
        print("Dữ liệu hợp đồng không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.contract;
      print("Gọi API hợp đồng: $fullUrl");
      print("Lỗi fetch hợp đồng: $e");
      print(stacktrace);
      ContactList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchRoomInfo() async {
    try {
      isLoading = true;
      notifyListeners();
      
      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.room;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.customer.getRoomInfo();
      final rawData = response.data['data']; 

      print("Dữ liệu phòng trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      if (rawData is List) {
        RoomList = rawData
            .map((e) => ThongTinPhong.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        RoomList = [ThongTinPhong.fromJson(rawData as Map<String, dynamic>)];
      } else {
        RoomList = [];
        print("Dữ liệu phòng không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.room;
      print("Gọi API phòng: $fullUrl");
      print("Lỗi fetch phòng: $e");
      print(stacktrace);
      RoomList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchRoomStatus() async {
    try {
      isLoading = true;
      notifyListeners();

      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.roomStatus;
      print("Gọi APP: $fullUrl");

      // Gọi API
      final response = await ApiRoutes.customer.getRoomStatus();
      final rawData = response.data;

      print("Dữ liệu phòng trả về: $rawData");
      print("Type of rawData: ${rawData.runtimeType}");

      if (rawData is Map<String, dynamic>) {
        final roomStatus = RoomStatusResponse.fromJson(rawData);
        RoomList = [roomStatus.data.thongTinPhong];
        DSKhachThue = roomStatus.data.danhSachNguoiThue.cast<KhachThue>();
        ThietBiList = roomStatus.data.thietBi;
        DichVuList = roomStatus.data.dichVuDangKy;
        HopDongList = roomStatus.data.thongTinHopDong;
      } else {
        RoomList = [];
        print("Dữ liệu phòng không hợp lệ");
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.roomStatus;
      print("Gọi API phòng: $fullUrl");
      print("Lỗi fetch phòng: $e");
      print(stacktrace);
      RoomList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}
