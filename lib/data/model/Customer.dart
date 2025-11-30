import 'package:flutter_application/UI/shared/parse_utils.dart';
import 'package:flutter_application/data/model/PhongTro.dart';
import 'package:intl/intl.dart';
// ===================================================================
// ============================= HÓA ĐƠN =============================
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

// ====================================================================
// ============================= HOP DONG =============================
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

// =================================================================
// ============================= PHONG =============================
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