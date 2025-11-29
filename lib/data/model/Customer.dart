import 'package:flutter_application/data/model/PhongTro.dart';

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

  HoaDonKhachThue( this.trangThai, {
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
      json['TrangThai'],
      maHoaDon: json['MaHoaDon'],
      maPhong: json['MaPhong'],
      maHopDong: json['MaHopDong'],
      thang: json['Thang'],
      ngayLap: json['NgayLap'],
      ngayHetHan: json['NgayHetHan'],
      tongTien: (json['TongTien'] as num).toDouble(),
      daThanhToan: (json['DaThanhToan'] as num).toDouble(),
      conLai: (json['ConLai'] as num).toDouble(),
      trangThaiText: json['TrangThaiText'],
      trangThaiColor: json['TrangThaiColor'],
      ghiChu: json['GhiChu'],
      phongTro:
          json['phongTro'] != null ? PhongTro.fromJson(json['phongTro']) : null,
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
      'chiTietHoaDon':
          chiTietHoaDon?.map((e) => e.toJson()).toList(),
      'thanhToan': thanhToan?.map((e) => e.toJson()).toList(),
    };
  }
}

class ChiTietHoaDonKhachThue {
  final int maChiTiet;
  final int maHoaDon;
  final String noiDung;
  final int soLuong;
  final double donGia;
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
      maChiTiet: json['MaChiTiet'],
      maHoaDon: json['MaHoaDon'],
      noiDung: json['NoiDung'],
      soLuong: json['SoLuong'],
      donGia: (json['DonGia'] as num).toDouble(),
      thanhTien: (json['ThanhTien'] as num).toDouble(),
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
      maThanhToan: json['MaThanhToan'],
      soTien: (json['SoTien'] as num).toDouble(),
      ngayThanhToan: json['NgayThanhToan'],
      phuongThuc: json['PhuongThuc'],
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
