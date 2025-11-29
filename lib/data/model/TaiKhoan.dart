import 'package:flutter_application/data/model/Khachthue.dart';
import 'package:flutter_application/data/model/NhanVien.dart';

class TaiKhoan {
  final int MaTaiKhoan;
  final String TenDangNhap;
  final int MaQuyen;
  final String TenQuyen;
  final String TrangThaiTaiKhoan;
  final NhanVien? nhanVien;
  final KhachThue? khachThue;

  TaiKhoan({
    required this.MaTaiKhoan,
    required this.TenDangNhap,
    required this.MaQuyen,
    required this.TenQuyen,
    required this.TrangThaiTaiKhoan,
    this.nhanVien,
    this.khachThue,
  });

  factory TaiKhoan.fromJson(Map<String, dynamic> json) {
    return TaiKhoan(
      MaTaiKhoan: json['MaTaiKhoan'],
      TenDangNhap: json['TenDangNhap'],
      MaQuyen: json['MaQuyen'],
      TenQuyen: json['TenQuyen'],
      TrangThaiTaiKhoan: json['TrangThaiTaiKhoan'],
      nhanVien: json['nhanVien'] != null ? NhanVien.fromJson(json['nhanVien']) : null,
      khachThue: json['khachThue'] != null ? KhachThue.fromJson(json['khachThue']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaTaiKhoan': MaTaiKhoan,
      'TenDangNhap': TenDangNhap,
      'MaQuyen': MaQuyen,
      'TenQuyen': TenQuyen,
      'TrangThaiTaiKhoan': TrangThaiTaiKhoan,
      'nhanVien': nhanVien?.toJson(),
      'khachThue': khachThue?.toJson(),
    };
  }
}
