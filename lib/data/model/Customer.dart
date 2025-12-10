import 'package:flutter_application/UI/shared/parse_utils.dart';
import 'package:flutter_application/data/model/DangKyDichVu.dart';
import 'package:flutter_application/data/model/Khachthue.dart';
import 'package:flutter_application/data/model/NoiQuy.dart';
import 'package:flutter_application/data/model/PhongTro.dart';
import 'package:flutter_application/data/model/ThietBi.dart';
import 'package:intl/intl.dart';
//  HÓA ĐƠN KHÁCH THuê 
class HoaDonKhachThue {
  final int maHoaDon;
  final int maPhong;
  final int? maHopDong;
  final String thang;
  final String ngayLap;
  final String ngayHetHan;
  final double tongTien;
  final double daThanhToan;
  final double conLai;
  final String trangThai;
  final String? trangThaiText;
  final String? trangThaiColor;
  final String? ghiChu;
  final PhongTro? phongTro;
  final List<ChiTietHoaDonKhachThue>? chiTietHoaDon;
  final List<ThanhToan>? thanhToan;

  HoaDonKhachThue(
    this.trangThai, {
    required this.maHoaDon,
    required this.maPhong,
    this.maHopDong,
    required this.thang,
    required this.ngayLap,
    required this.ngayHetHan,
    required this.tongTien,
    required this.daThanhToan,
    required this.conLai,
    this.trangThaiText,
    this.trangThaiColor,
    this.ghiChu,
    this.phongTro,
    this.chiTietHoaDon,
    this.thanhToan,
  });

  factory HoaDonKhachThue.fromJson(Map<String, dynamic> json) {
    return HoaDonKhachThue(
      json['TrangThai'] ?? '',
      maHoaDon: ParseUtils.toInt(json['MaHoaDon']),
      maPhong: ParseUtils.toInt(json['MaPhong']),
      maHopDong: json['MaHopDong'] != null ? ParseUtils.toInt(json['MaHopDong']) : null,
      thang: json['Thang'] ?? '',
      ngayLap: json['NgayLap'] ?? '',
      ngayHetHan: json['NgayHetHan'] ?? '',
      tongTien: ParseUtils.toDouble(json['TongTien']),
      daThanhToan: ParseUtils.toDouble(json['DaThanhToan']),
      conLai: ParseUtils.toDouble(json['ConLai']),
      trangThaiText: json['TrangThaiText'],
      trangThaiColor: json['TrangThaiColor'],
      ghiChu: json['GhiChu'],
      phongTro: json['phongTro'] != null ? PhongTro.fromJson(json['phongTro']) : null,
      chiTietHoaDon: json['chiTietHoaDon'] != null
          ? (json['chiTietHoaDon'] as List)
              .map((e) => ChiTietHoaDonKhachThue.fromJson(e))
              .toList()
          : null,
      thanhToan: json['thanhToan'] != null
          ? (json['thanhToan'] as List)
              .map((e) => ThanhToan.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaHoaDon': maHoaDon,
      'MaPhong': maPhong,
      'MaHopDong': maHopDong,
      'Thang': thang,
      'NgayLap': ngayLap,
      'NgayHetHan': ngayHetHan,
      'TongTien': tongTien,
      'DaThanhToan': daThanhToan,
      'ConLai': conLai,
      'TrangThai': trangThai,
      'TrangThaiText': trangThaiText,
      'TrangThaiColor': trangThaiColor,
      'GhiChu': ghiChu,
      'phongTro': phongTro?.toJson(),
      'chiTietHoaDon': chiTietHoaDon?.map((e) => e.toJson()).toList(),
      'thanhToan': thanhToan?.map((e) => e.toJson()).toList(),
    };
  }
}

// CHI TIẾT HÓA ĐƠN KHÁCH THUÊ
class ChiTietHoaDonKhachThue {
  final int maChiTiet;
  final int maHoaDon;
  final String noiDung;
  final int soLuong;
  final double? donGia;
  final double thanhTien;

  ChiTietHoaDonKhachThue({
    required this.maChiTiet,
    required this.maHoaDon,
    required this.noiDung,
    required this.soLuong,
    required this.donGia,
    required this.thanhTien,
  });

  factory ChiTietHoaDonKhachThue.fromJson(Map<String, dynamic> json) {
    return ChiTietHoaDonKhachThue(
      maChiTiet: ParseUtils.toInt(json['MaChiTiet']),
      maHoaDon: ParseUtils.toInt(json['MaHoaDon']),
      noiDung: json['NoiDung'] ?? '',
      soLuong: ParseUtils.toInt(json['SoLuong']),
      donGia: ParseUtils.toDouble(json['DonGia']),
      thanhTien: ParseUtils.toDouble(json['ThanhTien']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaChiTiet': maChiTiet,
      'MaHoaDon': maHoaDon,
      'NoiDung': noiDung,
      'SoLuong': soLuong,
      'DonGia': donGia,
      'ThanhTien': thanhTien,
    };
  }
}
// THANH TOÁN
class ThanhToan {
  final int maThanhToan;
  final double soTien;
  final String ngayThanhToan;
  final String phuongThuc;

  ThanhToan({
    required this.maThanhToan,
    required this.soTien,
    required this.ngayThanhToan,
    required this.phuongThuc,
  });

  factory ThanhToan.fromJson(Map<String, dynamic> json) {
    return ThanhToan(
      maThanhToan: ParseUtils.toInt(json['MaThanhToan']),
      soTien: ParseUtils.toDouble(json['SoTien']),
      ngayThanhToan: json['NgayThanhToan'] ?? '',
      phuongThuc: json['PhuongThuc'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaThanhToan': maThanhToan,
      'SoTien': soTien,
      'NgayThanhToan': ngayThanhToan,
      'PhuongThuc': phuongThuc,
    };
  }
}

// HOP DONG 
class ThongTinHopDong {
  final String soHopDong;
  final String tenPhong;
  final String tenKhachThue;
  final String sdt;
  final String trangThai;
  final DateTime ngayKy;
  final DateTime ngayBatDau;
  final DateTime ngayKetThuc;
  final double tienThueHangThang;
  final double tienCoc;
  final List<DichVu> dichVu;

  ThongTinHopDong({
    required this.soHopDong,
    required this.tenPhong,
    required this.tenKhachThue,
    required this.sdt,
    required this.trangThai,
    required this.ngayKy,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.tienThueHangThang,
    required this.tienCoc,
    required this.dichVu,
  });

  factory ThongTinHopDong.fromJson(Map<String, dynamic> json) {
    var dichVuList = <DichVu>[];
    if (json['DichVu'] != null) {
      dichVuList = List<Map<String, dynamic>>.from(json['DichVu'])
          .map((e) => DichVu.fromJson(e))
          .toList();
    }

    return ThongTinHopDong(
      soHopDong: json['SoHopDong'] ?? '',
      tenPhong: json['TenPhong'] ?? '',
      tenKhachThue: json['TenKhachThue'] ?? '',
      sdt: json['SDT'] ?? '',
      trangThai: json['TrangThai'] ?? '',
      ngayKy: parseDate(json['NgayKy']),
      ngayBatDau: parseDate(json['NgayBatDau']),
      ngayKetThuc: parseDate(json['NgayKetThuc']),
      tienThueHangThang:  ParseUtils.toDouble((json['TienThueHangThang'])),
      tienCoc:  ParseUtils.toDouble((json['TienCoc'])),
      dichVu: dichVuList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SoHopDong': soHopDong,
      'TenPhong': tenPhong,
      'TenKhachThue': tenKhachThue,
      'SDT': sdt,
      'TrangThai': trangThai,
      'NgayKy': ngayKy.toIso8601String(),
      'NgayBatDau': ngayBatDau.toIso8601String(),
      'NgayKetThuc': ngayKetThuc.toIso8601String(),
      'TienThueHangThang': tienThueHangThang,
      'TienCoc': tienCoc,
      'DichVu': dichVu.map((e) => e.toJson()).toList(),
    };
  }

  static DateTime parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return DateTime.now(); // hoặc null nếu muốn nullable
    }
    try {
      return DateFormat('dd/MM/yyyy').parse(dateStr);
    } catch (e) {
      return DateTime.now(); // fallback
    }
  }
}

// DICH VU CUSTOMER
class DichVu {
  String? tenDichVu;
  num? donGiaApDung;
  num? soLuong;
  String? donViTinh;

  DichVu({
    this.tenDichVu,
    this.donGiaApDung,
    this.soLuong,
    this.donViTinh,
  });

  factory DichVu.fromJson(Map<String, dynamic> json) {
    return DichVu(
      tenDichVu: json['TenDichVu'] as String?,
      donGiaApDung: ParseUtils.toDouble(json['DonGiaApDung']),
      soLuong: json['SoLuong'] as num?,
      donViTinh: json['DonViTinh'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'TenDichVu': tenDichVu,
        'DonGiaApDung': donGiaApDung,
        'SoLuong': soLuong,
        'DonViTinh': donViTinh,
      };
}

// THÔNG TIN PHÒNG
class ThongTinPhong {
  final int maKhachThue;
  final String hoTen;
  final String? cccd;
  final String? sdt1;
  final String? email;
  final PhongTro phongTro;

  ThongTinPhong({
    required this.maKhachThue,
    required this.hoTen,
    this.cccd,
    this.sdt1,
    this.email,
    required this.phongTro,
  });

  factory ThongTinPhong.fromJson(Map<String, dynamic> json) {
    return ThongTinPhong(
      maKhachThue: json['MaKhachThue'] ?? 0,
      hoTen: json['HoTen'] ?? '',
      cccd: json['CCCD'],
      sdt1: json['SDT1'],
      email: json['Email'],
      phongTro: PhongTro.fromJson(json['phongTro'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaKhachThue': maKhachThue,
      'HoTen': hoTen,
      'CCCD': cccd,
      'SDT1': sdt1,
      'Email': email,
      'phongTro': phongTro.toJson(),
    };
  }
}

// TRẠNG THÁI PHÒNG
class RoomStatusResponse {
  final bool? success;
  final RoomData data;

  RoomStatusResponse({required this.success, required this.data});

  factory RoomStatusResponse.fromJson(Map<String, dynamic> json) {
    return RoomStatusResponse(
      success: json['success'] ?? false,
      data: RoomData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

// TẤT CẢ DỮ LIỆU PHÒNG
class RoomData {
  final ThongTinPhong thongTinPhong;
  final ThongTinHopDong? thongTinHopDong;
  final List<KhachThue> danhSachNguoiThue;
  final List<ThietBi> thietBi;
  final List<DichVuDangKy> dichVuDangKy;

  RoomData({
    required this.thongTinPhong,
    this.thongTinHopDong,
    required this.danhSachNguoiThue,
    required this.thietBi,
    required this.dichVuDangKy,
  });

  factory RoomData.fromJson(Map<String, dynamic> json) {
    return RoomData(
      thongTinPhong: ThongTinPhong.fromJson(json['ThongTinPhong']),
      thongTinHopDong: json['ThongTinHopDong'] != null
          ? ThongTinHopDong.fromJson(json['ThongTinHopDong'])
          : null,
      danhSachNguoiThue: (json['DanhSachNguoiThue'] as List)
          .map((e) => KhachThue.fromJson(e))
          .toList(),
      thietBi: (json['ThietBi'] as List)
          .map((e) => ThietBi.fromJson(e))
          .toList(),
      dichVuDangKy: (json['DichVuDangKy'] as List)
          .map((e) => DichVuDangKy.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ThongTinPhong': thongTinPhong.toJson(),
      'ThongTinHopDong': thongTinHopDong?.toJson(),
      'DanhSachNguoiThue': danhSachNguoiThue.map((e) => e.toJson()).toList(),
      'ThietBi': thietBi.map((e) => e.toJson()).toList(),
      'DichVuDangKy': dichVuDangKy.map((e) => e.toJson()).toList(),
    };
  }
}


// KHÁCH THUÊ VI PHẠM
class ViPhamKhachThue {
  final int maViPham;
  final int maKhachThue;
  final int maNoiQuy;
  final String moTa;
  final String mucDo; // 'nhe' | 'vua' | 'nghiem_trong' | 'rat_nghiem_trong'
  final String trangThai; // 'da_bao_cao' | 'da_canh_cao' | 'da_giai_quyet'
  final String ngayBaoCao;
  final String? ngayGiaiQuyet;
  final String? ghiChu;

  final NoiQuy? noiQuy;
  final KhachThueViPham? khachThue;
  final NguoiBaoCao? nguoiBaoCao;

  ViPhamKhachThue({
    required this.maViPham,
    required this.maKhachThue,
    required this.maNoiQuy,
    required this.moTa,
    required this.mucDo,
    required this.trangThai,
    required this.ngayBaoCao,
    this.ngayGiaiQuyet,
    this.ghiChu,
    this.noiQuy,
    this.khachThue,
    this.nguoiBaoCao,
  });

  factory ViPhamKhachThue.fromJson(Map<String, dynamic> json) {
    return ViPhamKhachThue(
      maViPham: json['MaViPham'],
      maKhachThue: json['MaKhachThue'],
      maNoiQuy: json['MaNoiQuy'],
      moTa: json['MoTa'],
      mucDo: json['MucDo'],
      trangThai: json['TrangThai'],
      ngayBaoCao: json['NgayBaoCao'],
      ngayGiaiQuyet: json['NgayGiaiQuyet'],
      ghiChu: json['GhiChu'],
      noiQuy: json['noiQuy'] != null ? NoiQuy.fromJson(json['noiQuy']) : null,
      khachThue: json['khachThue'] != null ? KhachThueViPham.fromJson(json['khachThue']) : null,
      nguoiBaoCao: json['nguoiBaoCao'] != null ? NguoiBaoCao.fromJson(json['nguoiBaoCao']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaViPham': maViPham,
      'MaKhachThue': maKhachThue,
      'MaNoiQuy': maNoiQuy,
      'MoTa': moTa,
      'MucDo': mucDo,
      'TrangThai': trangThai,
      'NgayBaoCao': ngayBaoCao,
      'NgayGiaiQuyet': ngayGiaiQuyet,
      'GhiChu': ghiChu,
      'noiQuy': noiQuy?.toJson(),
      'khachThue': khachThue?.toJson(),
      'nguoiBaoCao': nguoiBaoCao?.toJson(),
    };
  }
}

class KhachThueViPham {
  final int maKhachThue;
  final String hoTen;
  final PhongTro phongTro;

  KhachThueViPham({
    required this.maKhachThue,
    required this.hoTen,
    required this.phongTro,
  });

  factory KhachThueViPham.fromJson(Map<String, dynamic> json) {
    return KhachThueViPham(
      maKhachThue: json['MaKhachThue'],
      hoTen: json['HoTen'],
      phongTro: PhongTro.fromJson(json['phongTro']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaKhachThue': maKhachThue,
      'HoTen': hoTen,
      'phongTro': phongTro.toJson(),
    };
  }
}

class NguoiBaoCao {
  final String hoTen;
  NguoiBaoCao({required this.hoTen});
  factory NguoiBaoCao.fromJson(Map<String, dynamic> json) {
    return NguoiBaoCao(
      hoTen: json['HoTen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'HoTen': hoTen,
    };
  }
}

class CreateViPhamRequest {
  int maKhachThue;
  int maNoiQuy;
  String moTa;
  String mucDo; // nhe | vua | nghiem_trong | rat_nghiem_trong
  String ngayBaoCao;

  CreateViPhamRequest({
    required this.maKhachThue,
    required this.maNoiQuy,
    required this.moTa,
    required this.mucDo,
    required this.ngayBaoCao,
  });

  factory CreateViPhamRequest.fromJson(Map<String, dynamic> json) {
    return CreateViPhamRequest(
      maKhachThue: json['MaKhachThue'],
      maNoiQuy: json['MaNoiQuy'],
      moTa: json['MoTa'],
      mucDo: json['MucDo'],
      ngayBaoCao: json['NgayBaoCao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaKhachThue': maKhachThue,
      'MaNoiQuy': maNoiQuy,
      'MoTa': moTa,
      'MucDo': mucDo,
      'NgayBaoCao': ngayBaoCao,
    };
  }
}

class RoomInBuilding {
  final int maPhong;
  final String tenPhong;

  RoomInBuilding({
    required this.maPhong,
    required this.tenPhong,
  });

  factory RoomInBuilding.fromJson(Map<String, dynamic> json) {
    return RoomInBuilding(
      maPhong: json['MaPhong'] ?? 0,
      tenPhong: json['TenPhong'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaPhong': maPhong,
      'TenPhong': tenPhong,
    };
  }
}

class TenantByRoom {
  final int maKhachThue;
  final String hoTen;

  TenantByRoom({
    required this.maKhachThue,
    required this.hoTen,
  });

  factory TenantByRoom.fromJson(Map<String, dynamic> json) {
    return TenantByRoom(
      maKhachThue: json['MaKhachThue'] ?? 0,
      hoTen: json['HoTen'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaKhachThue': maKhachThue,
      'HoTen': hoTen,
    };
  }
}

// YÊU CẦU SỬA CHỮA
class YeuCauSuaChuaKhachThue {
  int maYeuCau;
  int maKhachThue;
  String tieuDe;
  String moTa;
  String phanLoai;
  String mucDoUuTien;
  String trangThai;
  String ngayYeuCau;
  String? ngayPhanCong;
  String? ngayHoanThanh;
  String? ghiChu;
  double? chiPhiThucTe;
  List<String>? hinhAnhMinhChung;

  KhachThueInfo? khachThue;
  NhanVienPhanCong? nhanVienPhanCong;

  YeuCauSuaChuaKhachThue({
    required this.maYeuCau,
    required this.maKhachThue,
    required this.tieuDe,
    required this.moTa,
    required this.phanLoai,
    required this.mucDoUuTien,
    required this.trangThai,
    required this.ngayYeuCau,
    this.ngayPhanCong,
    this.ngayHoanThanh,
    this.ghiChu,
    this.chiPhiThucTe,
    this.hinhAnhMinhChung,
    this.khachThue,
    this.nhanVienPhanCong,
  });

  factory YeuCauSuaChuaKhachThue.fromJson(Map<String, dynamic>? json) {
    if (json == null) throw Exception("JSON null");

    return YeuCauSuaChuaKhachThue(
      maYeuCau: json['MaYeuCau'] ?? 0,
      maKhachThue: json['MaKhachThue'] ?? 0,
      tieuDe: json['TieuDe'] ?? '',
      moTa: json['MoTa'] ?? '',
      phanLoai: json['PhanLoai'] ?? '',
      mucDoUuTien: json['MucDoUuTien'] ?? '',
      trangThai: json['TrangThai'] ?? '',
      ngayYeuCau: json['NgayYeuCau'] ?? '',
      ngayPhanCong: json['NgayPhanCong'],
      ngayHoanThanh: json['NgayHoanThanh'],
      ghiChu: json['GhiChu'],
      chiPhiThucTe: json['ChiPhiThucTe'] != null
          ? double.tryParse(json['ChiPhiThucTe'].toString())
          : null,
      hinhAnhMinhChung: (json['HinhAnhMinhChung'] is List)
          ? List<String>.from(json['HinhAnhMinhChung'])
          : null,
      khachThue: json['khachThue'] != null
          ? KhachThueInfo.fromJson(json['khachThue'])
          : null,
      nhanVienPhanCong: json['nhanVienPhanCong'] != null
          ? NhanVienPhanCong.fromJson(json['nhanVienPhanCong'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'MaYeuCau': maYeuCau,
        'MaKhachThue': maKhachThue,
        'TieuDe': tieuDe,
        'MoTa': moTa,
        'PhanLoai': phanLoai,
        'MucDoUuTien': mucDoUuTien,
        'TrangThai': trangThai,
        'NgayYeuCau': ngayYeuCau,
        'NgayPhanCong': ngayPhanCong,
        'NgayHoanThanh': ngayHoanThanh,
        'GhiChu': ghiChu,
        'ChiPhiThucTe': chiPhiThucTe,
        'HinhAnhMinhChung': hinhAnhMinhChung,
        'khachThue': khachThue?.toJson(),
        'nhanVienPhanCong': nhanVienPhanCong?.toJson(),
      };
}

class KhachThueInfo {
  int maKhachThue;
  String hoTen;
  String? tenPhong;

  KhachThueInfo({
    required this.maKhachThue,
    required this.hoTen,
    this.tenPhong,
  });

  factory KhachThueInfo.fromJson(Map<String, dynamic>? json) {
    if (json == null) throw Exception("khachThue JSON null");

    return KhachThueInfo(
      maKhachThue: json['MaKhachThue'] ?? 0,
      hoTen: json['HoTen'] ?? '',
      tenPhong: json['TenPhong'],
    );
  }

  Map<String, dynamic> toJson() => {
        'MaKhachThue': maKhachThue,
        'HoTen': hoTen,
        'TenPhong': tenPhong,
      };
}

class NhanVienPhanCong {
  int maNhanVien;
  String hoTen;

  NhanVienPhanCong({
    required this.maNhanVien,
    required this.hoTen,
  });

  factory NhanVienPhanCong.fromJson(Map<String, dynamic>? json) {
    if (json == null) throw Exception("nhanVienPhanCong JSON null");

    return NhanVienPhanCong(
      maNhanVien: json['MaNhanVien'] ?? 0,
      hoTen: json['HoTen'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'MaNhanVien': maNhanVien,
        'HoTen': hoTen,
      };
}
class CreateYeuCauSuaChuaRequest {
  int? maKhachThue; 
  String tieuDe;
  String moTa;
  String phanLoai; // electrical | plumbing | appliance | furniture | other
  String mucDoUuTien; // low | medium | high | urgent
  String? ghiChu;

  CreateYeuCauSuaChuaRequest({
    this.maKhachThue,
    required this.tieuDe,
    required this.moTa,
    required this.phanLoai,
    required this.mucDoUuTien,
    this.ghiChu,
  });

  factory CreateYeuCauSuaChuaRequest.fromJson(Map<String, dynamic> json) {
    return CreateYeuCauSuaChuaRequest(
      maKhachThue: json['MaKhachThue'],
      tieuDe: json['TieuDe'],
      moTa: json['MoTa'],
      phanLoai: json['PhanLoai'],
      mucDoUuTien: json['MucDoUuTien'],
      ghiChu: json['GhiChu'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaKhachThue': maKhachThue,
      'TieuDe': tieuDe,
      'MoTa': moTa,
      'PhanLoai': phanLoai,
      'MucDoUuTien': mucDoUuTien,
      'GhiChu': ghiChu,
    };
  }
}


