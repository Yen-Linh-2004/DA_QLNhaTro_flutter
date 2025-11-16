import 'package:flutter_application/Server/model/PhongTro.dart';

class KhachThue {
  final int maKhachThue;
  final String hoTen;
  final String? cccd;
  final DateTime? ngayCapCCCD;
  final String? noiCapCCCD;
  final String sdt1;
  final String? sdt2;
  final String? email;
  final String? diaChiThuongTru;
  final DateTime? ngaySinh;
  final String? noiSinh;
  final String? hinhAnh;
  final int? maTaiKhoan;
  final int? maPhong;
  final String vaiTro;
  final int soXe;
  final String? bienSoXe;
  final int? maLoaiXe;
  final String? ghiChu;

  // Computed fields
  final String? tenPhong;
  final String? diaChiDay;

  // Relationship
  final PhongTro? phongTro;

  KhachThue({
    required this.maKhachThue,
    required this.hoTen,
    this.cccd,
    this.ngayCapCCCD,
    this.noiCapCCCD,
    required this.sdt1,
    this.sdt2,
    this.email,
    this.diaChiThuongTru,
    this.ngaySinh,
    this.noiSinh,
    this.hinhAnh,
    this.maTaiKhoan,
    this.maPhong,
    required this.vaiTro,
    required this.soXe,
    this.bienSoXe,
    this.maLoaiXe,
    this.ghiChu,
    this.tenPhong,
    this.diaChiDay,
    this.phongTro,
  });

  // Tạo instance từ JSON
  factory KhachThue.fromJson(Map<String, dynamic> json) {
    return KhachThue(
      maKhachThue: json['MaKhachThue'] ?? 0,
      hoTen: json['HoTen'] ?? '',
      cccd: json['CCCD'],
      ngayCapCCCD: json['NgayCapCCCD'] != null
          ? DateTime.tryParse(json['NgayCapCCCD'])
          : null,
      noiCapCCCD: json['NoiCapCCCD'],
      sdt1: json['SDT1'] ?? '',
      sdt2: json['SDT2'],
      email: json['Email'],
      diaChiThuongTru: json['DiaChiThuongTru'],
      ngaySinh: json['NgaySinh'] != null
          ? DateTime.tryParse(json['NgaySinh'])
          : null,
      noiSinh: json['NoiSinh'],
      hinhAnh: json['HinhAnh'],
      maTaiKhoan: json['MaTaiKhoan'],
      maPhong: json['MaPhong'],
      vaiTro: json['VaiTro'] ?? '',
      soXe: json['SoXe'] ?? 0,
      bienSoXe: json['BienSoXe'],
      maLoaiXe: json['MaLoaiXe'],
      ghiChu: json['GhiChu'],
      tenPhong: json['TenPhong'],
      diaChiDay: json['DiaChiDay'],
      phongTro: json['phongTro'] != null
          ? PhongTro.fromJson(json['phongTro'])
          : null,
    );
  }

  // Chuyển model sang JSON
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
}

