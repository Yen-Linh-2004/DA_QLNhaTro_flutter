import 'package:flutter_application/data/model/Khachthue.dart';
import 'package:flutter_application/data/model/NhanVien.dart';

enum PhanQuyenEnum {
  chuTro(0),
  quanLy(1),
  nhanVien(2),
  khachThue(3);

  final int id;
  const PhanQuyenEnum(this.id);

  static PhanQuyenEnum fromInt(int? value) {
    return PhanQuyenEnum.values.firstWhere(
      (e) => e.id == value,
      orElse: () => PhanQuyenEnum.khachThue,
    );
  }
}

class TaiKhoan {
  final int maTaiKhoan;
  final String tenDangNhap;
  final String? matKhau; 
  final PhanQuyenEnum maQuyen;
  final String trangThaiTaiKhoan;

  final NhanVien? nhanVien;
  final KhachThue? khachThue;

  TaiKhoan({
    required this.maTaiKhoan,
    required this.tenDangNhap,
    this.matKhau,
    required this.maQuyen,
    required this.trangThaiTaiKhoan,
    this.nhanVien,
    this.khachThue,
  });

  dynamic get profile {
    if (maQuyen == PhanQuyenEnum.nhanVien || maQuyen == PhanQuyenEnum.quanLy) {
      return nhanVien;
    } else if (maQuyen == PhanQuyenEnum.khachThue) {
      return khachThue;
    }
    return null;
  }

  factory TaiKhoan.fromJson(Map<String, dynamic> json) {
    return TaiKhoan(
      maTaiKhoan: json['MaTaiKhoan'] ?? 0,
      tenDangNhap: json['TenDangNhap'] ?? '',
      matKhau: json['MatKhau'],
      maQuyen: PhanQuyenEnum.fromInt(json['MaQuyen']),
      trangThaiTaiKhoan: json['TrangThaiTaiKhoan'] ?? '',
      nhanVien: json['NhanVien'] != null ? NhanVien.fromJson(json['NhanVien']) : null,
      khachThue: json['KhachThue'] != null ? KhachThue.fromJson(json['KhachThue']) : null,
     
      
    );
  }

  get data => null;

  Map<String, dynamic> toJson() {
    return {
      'MaTaiKhoan': maTaiKhoan,
      'TenDangNhap': tenDangNhap,
      'MatKhau': matKhau, 
      'MaQuyen': maQuyen.toString().split('.').last,
      'TrangThaiTaiKhoan': trangThaiTaiKhoan,
      'NhanVien': nhanVien?.toJson(),
      'KhachThue': khachThue?.toJson(),
    };
  }

  static PhanQuyenEnum _phanQuyenFromString(String? value) {
    switch (value) {
      case 1:
        return PhanQuyenEnum.nhanVien;
      case 2:
        return PhanQuyenEnum.quanLy;
      case 3:
        return PhanQuyenEnum.khachThue;
      default:
        return PhanQuyenEnum.khachThue; // mặc định
    }
  }
}
