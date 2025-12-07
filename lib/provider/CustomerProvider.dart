import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/api_routes.dart';
import 'package:flutter_application/core/network/endpoints.dart';
import 'package:flutter_application/data/model/Customer.dart';
import 'package:flutter_application/data/model/DangKyDichVu.dart';
import 'package:flutter_application/data/model/Khachthue.dart';
import 'package:flutter_application/data/model/ThietBi.dart';

class CustomerProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingdetail = false;
  List<HoaDonKhachThue> InvoicesList = [];
  List<ThongTinHopDong> ContactList = [];
  List<ThongTinPhong> RoomList = [];
  List<ThietBi> ThietBiList = [];
  List<KhachThue> DSKhachThue = [];
  List<DichVuDangKy> DichVuList = [];
  List<RoomData> roomStatusList = [];
  List<ViPhamKhachThue> vipham = [];
  List<YeuCauSuaChuaKhachThue> maintenance = [];
  
  ThongTinHopDong? HopDongList;
  ThongTinPhong? thongTinPhong;
  ThongTinHopDong? thongTinHopDong;
  YeuCauSuaChuaKhachThue? maintenancedetail;

  Future<void> fetchInvoice() async {
    try {
      isLoading = true;
      notifyListeners();

      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.invoices;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.customer.getInvoice();
      final rawData = response.data['data']; 

      print("Dữ liệu hóa đơn trả về: $rawData");
      
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

      final fullUrl =
          ApiRoutes.customer.dio.options.baseUrl + Endpoints.roomStatus;
      print("Gọi APP: $fullUrl");

      final response = await ApiRoutes.customer.getRoomStatus();

      if (response.data == null || response.data['data'] == null) {
        print("API không có trường data");
        return;
      }

      final rawData = response.data['data'];
      print("Dữ liệu trả về: $rawData");
      print("Type: ${rawData.runtimeType}");

      if (rawData is! Map<String, dynamic>) {
        print("Dữ liệu không phải Map<String, dynamic>");
        return;
      }

      final roomData = RoomData.fromJson(rawData);

      thongTinPhong = roomData.thongTinPhong;
      thongTinHopDong = roomData.thongTinHopDong;

      DSKhachThue = roomData.danhSachNguoiThue;
      ThietBiList = roomData.thietBi;
      DichVuList = roomData.dichVuDangKy;

      roomStatusList = [roomData];

      print("✔ Load phòng thành công");
    } catch (e, stacktrace) {
      print("Lỗi fetchRoomStatus: $e");
      print(stacktrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCustomerViolations() async {
    try {
      isLoading = true;
      notifyListeners();

      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.violations;
      print("Gọi API vi phạm: $fullUrl");

      final response = await ApiRoutes.customer.getCustomerViolations();

      if (response.data == null || response.data['data'] == null) {
        print("API trả về null");
        vipham = [];
        return;
      }

      final rawData = response.data['data'];

      print("Dữ liệu trả về: $rawData");
      print("Type: ${rawData.runtimeType}");

      if (rawData is List) {
        vipham = rawData
            .map((e) => ViPhamKhachThue.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map) {
        vipham = [ViPhamKhachThue.fromJson(rawData as Map<String, dynamic>)];
      } else {
        print("Dữ liệu không hợp lệ");
        vipham = [];
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.violations;
      print("Gọi API vi phạm lỗi: $fullUrl");
      print("Lỗi: $e");
      print(stacktrace);

      vipham = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createViolations(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      print("Gửi API tạo vi phạm: $data");

      final response = await ApiRoutes.customer.createViolations(data);

      if (response.statusCode != 200) {
        print("API trả về lỗi: ${response.statusCode}");
        return;
      }

      if (response.data == null || response.data['data'] == null) {
        print("⚠ Backend không trả về trường 'data'");
        return;
      }

      final rawData = response.data['data'];
      late ViPhamKhachThue newreport;
      if (rawData is Map<String, dynamic>) {
        newreport = ViPhamKhachThue.fromJson(rawData);
      } else if (rawData is List && rawData.isNotEmpty) {
        newreport = ViPhamKhachThue.fromJson(rawData.first);
      } else {
        print("⚠ Dữ liệu 'data' trả về không hợp lệ");
        return;
      }
      vipham.add(newreport);
      print("✔ Thêm báo cáo thành công: ${newreport.khachThue?.maKhachThue ?? 'Không có mã'}");
      notifyListeners();
    } on DioException catch (e) {
      print("Lỗi Dio (tạo báo cáo): ${e.response?.data}");
      print("Status: ${e.response?.statusCode}");
    } catch (e, stacktrace) {
      print("Lỗi không xác định: $e");
      print("Stacktrace: $stacktrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchMaintenanceRequest() async {
    try {
      isLoading = true;
      notifyListeners();

      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.maintenance;
      print("Gọi API yêu cầu sửa chữa: $fullUrl");

      final response = await ApiRoutes.customer.getMaintenanceRequest();

      if (response.data == null ||
          response.data["data"] == null) {
        print("API trả về null hoặc không có 'data'");
        maintenance = [];
        return;
      }

      final rawData = response.data["data"];

      print("Dữ liệu trả về: $rawData");
      print("Type: ${rawData.runtimeType}");

      if (rawData is List) {
        maintenance = rawData
            .map((e) => YeuCauSuaChuaKhachThue.fromJson(e as Map<String, dynamic>)).toList();
      } else if (rawData is Map) {
        maintenance = [
          YeuCauSuaChuaKhachThue.fromJson(rawData as Map<String, dynamic>)
        ];
      } else {
        print("Dữ liệu không hợp lệ, reset về rỗng");
        maintenance = [];
      }
    } catch (e, stacktrace) {
      final fullUrl = ApiRoutes.customer.dio.options.baseUrl + Endpoints.maintenance;
      print("Lỗi khi gọi API: $fullUrl");
      print("Exception: $e");
      print(stacktrace);
      maintenance = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMaintainerRequestById(int id) async {
    try {
      isLoadingdetail = true;
      notifyListeners();
      
      print(" Bắt đầu fetch maintenance với ID: $id");
      final response = await ApiRoutes.customer.getMaintenanceRequestById(id);
      print("Response status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode != 200) {
        print("API trả về lỗi: ${response.statusCode}");
        maintenancedetail = null;
        return;
      }

      final rawData = response.data['data'];

      if (rawData is Map) {
        maintenancedetail = YeuCauSuaChuaKhachThue.fromJson(rawData as Map<String, dynamic>);
        print("Chuyển sang model: ${maintenancedetail?.toJson()}");
      } else if (rawData is List && rawData.isNotEmpty) {
        maintenancedetail = YeuCauSuaChuaKhachThue.fromJson(rawData.first as Map<String, dynamic>);
        print("Chuyển sang model từ List: ${maintenancedetail?.toJson()}");
      } else {
        maintenancedetail = null;
        print("Dữ liệu maintenance theo ID không hợp lệ");
      }

    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        print(" Lỗi server (500): ${e.response?.data}");
      } else {
        print(" Lỗi Dio khác: $e");
      }
      maintenancedetail = null;
    } catch (e, stacktrace) {
      print(" Lỗi fetchMaintainerRequestById: $e");
      print(stacktrace);
      maintenancedetail = null;
    } finally {
      isLoadingdetail = false;
      notifyListeners();
      print("Kết thúc fetch fetchMaintainerRequestById, isLoading = $isLoadingdetail");
    }
  }

}
