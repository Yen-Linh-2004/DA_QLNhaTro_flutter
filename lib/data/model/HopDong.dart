import 'package:flutter_application/data/model/Khachthue.dart';
import 'package:flutter_application/data/model/PhongTro.dart';

class HopDong {
  final int maHopDong;
  final String soHopDong;
  final int maPhong;
  final int? maKhachThue;

  final DateTime ngayKy;
  final DateTime ngayBatDau;
  final DateTime ngayKetThuc;
  final double tienCoc;
  final double tienThueHangThang;
  final String trangThai;
  final String? ghiChu;
  final int? soLanGiaHan;
  final String? tenKhachThue;
  final String? tenPhong;
  final String? tenDay;
  final PhongTro? phongTro;
  final KhachThue? khachThue;
  final List<dynamic> hopDongDichVus;

  HopDong({
    required this.maHopDong,
    required this.soHopDong,
    required this.maPhong,
    this.maKhachThue,
    required this.ngayKy,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.tienCoc,
    required this.tienThueHangThang,
    required this.trangThai,
    this.ghiChu,
    this.soLanGiaHan,
    this.tenKhachThue,
    this.tenPhong,
    this.tenDay,
    this.phongTro,
    this.khachThue,
    required this.hopDongDichVus,
  });

  factory HopDong.fromJson(Map<String, dynamic> json) {
    return HopDong(
      maHopDong: json["MaHopDong"],
      soHopDong: json["SoHopDong"],
      maPhong: json["MaPhong"],
      maKhachThue: json["MaKhachThue"] ?? 0,

      ngayKy: _parseDate(json["NgayKy"]),
      ngayBatDau: _parseDate(json["NgayBatDau"]),
      ngayKetThuc: _parseDate(json["NgayKetThuc"]),

      tienCoc: double.parse(json["TienCoc"].toString()),
      tienThueHangThang: double.parse(json["TienThueHangThang"].toString()),

      trangThai: json["TrangThai"],
      ghiChu: json["GhiChu"],
      soLanGiaHan: json["SoLanGiaHan"] ?? 0,
      tenKhachThue: json["TenKhachThue"],
      tenPhong: json["TenPhong"],
      tenDay: json["TenDay"],
      phongTro: (json["phongTro"] is Map<String, dynamic>)
        ? PhongTro.fromJson(json["phongTro"])
        : null,
      khachThue: (json["khachThue"] is Map<String, dynamic>)
          ? KhachThue.fromJson(json["khachThue"])
          : null,
      hopDongDichVus: json["hopDongDichVus"] ?? [],
    );
  }

  static DateTime _parseDate(String raw) {
    if (raw.contains("/")) {
      final p = raw.split("/");
      return DateTime(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]));
    }
    return DateTime.parse(raw);
  }
  
  toJson() {}
}
