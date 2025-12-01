import 'package:flutter_application/data/model/PhongTro.dart';

class KhachThue {
  final int maKhachThue;
  final String hoTen;
  final String? cccd;
  final DateTime? ngayCapCCCD;
  final String? noiCapCCCD;
  final String? sdt1;
  final String? sdt2;
  final String? email;
  final String? diaChiThuongTru;
  final DateTime? ngaySinh;
  final String? noiSinh;
  final String? hinhAnh;
  final int? maTaiKhoan;
  final int? maPhong;
  final String? vaiTro;
  final int? soXe;
  final String? bienSoXe;
  final int? maLoaiXe;
  final String? ghiChu;
  final String? tenPhong;
  final String? diaChiDay;
  final PhongTro? phongTro;

  KhachThue({
    required this.maKhachThue,
    required this.hoTen,
    this.cccd,
    this.ngayCapCCCD,
    this.noiCapCCCD,
    this.sdt1,
    this.sdt2,
    this.email,
    this.diaChiThuongTru,
    this.ngaySinh,
    this.noiSinh,
    this.hinhAnh,
    this.maTaiKhoan,
    this.maPhong,
    this.vaiTro,
    this.soXe,
    this.bienSoXe,
    this.maLoaiXe,
    this.ghiChu,
    this.tenPhong,
    this.diaChiDay,
    this.phongTro,
  });

  factory KhachThue.fromJson(Map<String, dynamic> json) {
    return KhachThue(
      maKhachThue: json['MaKhachThue'] ?? 0,
      hoTen: json['HoTen'] ?? '',               
      cccd: json['CCCD'] as String?,
      ngayCapCCCD: _tryParseDate(json['NgayCapCCCD']), 
      noiCapCCCD: json['NoiCapCCCD'] as String?,
      sdt1: json['SDT1'] as String?,            
      sdt2: json['SDT2'] as String?,
      email: json['Email'] as String?,
      diaChiThuongTru: json['DiaChiThuongTru'] as String?,
      ngaySinh: _tryParseDate(json['NgaySinh']), 
      noiSinh: json['NoiSinh'] as String?,
      hinhAnh: json['HinhAnh'] as String?,
      maTaiKhoan: json['MaTaiKhoan'] != null ? int.tryParse(json['MaTaiKhoan'].toString()) : null,
      maPhong: json['MaPhong'] != null ? int.tryParse(json['MaPhong'].toString()) : null,
      vaiTro: json['VaiTro'] as String?,
      soXe: json['SoXe'] != null ? int.tryParse(json['SoXe'].toString()) : null,
      bienSoXe: json['BienSoXe'] as String?,
      maLoaiXe: json['MaLoaiXe'] != null ? int.tryParse(json['MaLoaiXe'].toString()) : null,
      ghiChu: json['GhiChu'] as String?,
      tenPhong: json['TenPhong'] as String?,
      diaChiDay: json['DiaChiDay'] as String?,
      phongTro: json['phongTro'] != null
          ? PhongTro.fromJson(json['phongTro'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaKhachThue': maKhachThue,
      'HoTen': hoTen,
      'CCCD': cccd,
      'NgayCapCCCD': ngayCapCCCD?.toIso8601String(),
      'NoiCapCCCD': noiCapCCCD,
      'SDT1': sdt1,
      'SDT2': sdt2,
      'Email': email,
      'DiaChiThuongTru': diaChiThuongTru,
      'NgaySinh': ngaySinh?.toIso8601String(),
      'NoiSinh': noiSinh,
      'HinhAnh': hinhAnh,
      'MaTaiKhoan': maTaiKhoan,
      'MaPhong': maPhong,
      'VaiTro': vaiTro,
      'SoXe': soXe,
      'BienSoXe': bienSoXe,
      'MaLoaiXe': maLoaiXe,
      'GhiChu': ghiChu,
      'TenPhong': tenPhong,
      'DiaChiDay': diaChiDay,
      'phongTro': phongTro?.toJson(),
    };
  }

  static List<KhachThue> listFromJson(dynamic json) {
    if (json == null) return [];
    if (json is List) {
      return json.map((e) => KhachThue.fromJson(e)).toList();
    } else if (json is Map) {
      return [KhachThue.fromJson(json as Map<String, dynamic>)];
    } else {
      return [];
    }
  }

  /// Parse DateTime null-safe
  static DateTime? _tryParseDate(dynamic raw) {
    if (raw == null) return null;
    try {
      final s = raw.toString();
      if (s.contains("/")) {
        final p = s.split("/");
        return DateTime(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]));
      }
      return DateTime.parse(s);
    } catch (_) {
      return null;
    }
  }
}
