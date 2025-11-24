import 'package:flutter_application/data/model/Khachthue.dart';
import 'package:flutter_application/data/model/NhanVien.dart';

enum PhanQuyenEnum { nhanVien, quanLy, khachThue }

class TaiKhoan {
  final int maTaiKhoan;
  final String tenDangNhap;
  final String? matKhau; // ẩn khi serialize
  final PhanQuyenEnum maQuyen;
  final String trangThaiTaiKhoan;

  // Quan hệ một-một (nullable nếu chưa load)
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

  /// Computed property tương tự `getProfileAttribute` trong Laravel
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
      maQuyen: _phanQuyenFromString(json['MaQuyen']),
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
      // 'MatKhau': matKhau, // thường ẩn
      'MaQuyen': maQuyen.toString().split('.').last,
      'TrangThaiTaiKhoan': trangThaiTaiKhoan,
      'NhanVien': nhanVien?.toJson(),
      'KhachThue': khachThue?.toJson(),
    };
  }

  static PhanQuyenEnum _phanQuyenFromString(String? value) {
    switch (value) {
      case 'NHAN_VIEN':
        return PhanQuyenEnum.nhanVien;
      case 'QUAN_LY':
        return PhanQuyenEnum.quanLy;
      case 'KHACH_THUE':
        return PhanQuyenEnum.khachThue;
      default:
        return PhanQuyenEnum.khachThue; // mặc định
    }
  }
}
