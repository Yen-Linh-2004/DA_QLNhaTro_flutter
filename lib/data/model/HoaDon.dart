import 'package:flutter_application/data/model/Customer.dart';
import 'package:flutter_application/data/model/HopDong.dart';
import 'package:flutter_application/data/model/PhongTro.dart';

enum TrangThaiHoaDonEnum {
  choXacNhan,
  daXacNhan,
  hoanThanh,
  daHuy,
}

class HoaDon {
  final int maHoaDon;
  final int maPhong;
  final int? maHopDong;
  final String thang;
  final DateTime ngayLap;
  final DateTime ngayHetHan;
  final double tongTien;
  final double daThanhToan;
  final double conLai;
  final TrangThaiHoaDonEnum trangThai;
  final String? ghiChu;

  final HopDong? hopDong;
  final PhongTro? phongTro;
  final List<ChiTietHoaDonKhachThue>? chiTietHoaDon;
  final List<ThanhToan>? thanhToan;

  HoaDon({
    required this.maHoaDon,
    required this.maPhong,
    this.maHopDong,
    required this.thang,
    required this.ngayLap,
    required this.ngayHetHan,
    required this.tongTien,
    required this.daThanhToan,
    required this.conLai,
    required this.trangThai,
    this.ghiChu,
    this.hopDong,
    this.phongTro,
    this.chiTietHoaDon,
    this.thanhToan,
  });

  factory HoaDon.fromJson(Map<String, dynamic> json) {
    return HoaDon(
      maHoaDon: json['MaHoaDon'],
      maPhong: json['MaPhong'],
      maHopDong: json['MaHopDong'],
      thang: json['Thang'],
      ngayLap: DateTime.parse(json['NgayLap']),
      ngayHetHan: DateTime.parse(json['NgayHetHan']),
      tongTien: _parseNum(json['TongTien']),
      daThanhToan: _parseNum(json['DaThanhToan']),
      conLai: _parseNum(json['ConLai']),
      trangThai: _parseTrangThai(json['TrangThai']),
      ghiChu: json['GhiChu'],
      hopDong: json['hopDong'] != null ? HopDong.fromJson(json['hopDong']) : null,
      phongTro: json['phongTro'] != null ? PhongTro.fromJson(json['phongTro']) : null,
      chiTietHoaDon: json['chiTietHoaDon'] != null
          ? (json['chiTietHoaDon'] as List)
              .map((e) => ChiTietHoaDonKhachThue.fromJson(e))
              .toList()
          : [],
      thanhToan: json['thanhToan'] != null
          ? (json['thanhToan'] as List).map((e) => ThanhToan.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaHoaDon': maHoaDon,
      'MaPhong': maPhong,
      'MaHopDong': maHopDong,
      'Thang': thang,
      'NgayLap': ngayLap.toIso8601String(),
      'NgayHetHan': ngayHetHan.toIso8601String(),
      'TongTien': tongTien,
      'DaThanhToan': daThanhToan,
      'ConLai': conLai,
      'TrangThai': trangThai.name,
      'GhiChu': ghiChu,
      'hopDong': hopDong,
      'phongTro': phongTro?.toJson(),
      'chiTietHoaDon': chiTietHoaDon?.map((e) => e.toJson()).toList(),
      'thanhToan': thanhToan?.map((e) => e.toJson()).toList(),
    };
  }

  static double _parseNum(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static TrangThaiHoaDonEnum _parseTrangThai(String? value) {
    switch (value) {
      case 'Chờ xác nhận':
        return TrangThaiHoaDonEnum.choXacNhan;
      case 'Đã xác nhận':
        return TrangThaiHoaDonEnum.daXacNhan;
      case 'Hoàn thành':
        return TrangThaiHoaDonEnum.hoanThanh;
      case 'Đã hủy':
        return TrangThaiHoaDonEnum.daHuy;
      default:
        return TrangThaiHoaDonEnum.choXacNhan;
    }
  }
}
