import 'TaiKhoan.dart';

class NhanVien {
  final int maNV;
  final String hoTen;
  final String? sdt;
  final String? email;
  final int? maTaiKhoan; // Nếu API trả về liên kết với tài khoản

  final TaiKhoan? taiKhoan; // Nested tài khoản (nếu có)

  NhanVien({
    required this.maNV,
    required this.hoTen,
    this.sdt,
    this.email,
    this.maTaiKhoan,
    this.taiKhoan,
  });

  // Tạo object từ JSON
  factory NhanVien.fromJson(Map<String, dynamic> json) {
    return NhanVien(
      maNV: json['MaNV'] ?? 0,
      hoTen: json['HoTen'] ?? '',
      sdt: json['SDT'],
      email: json['Email'],
      maTaiKhoan: json['MaTaiKhoan'],
      taiKhoan: json['taiKhoan'] != null
          ? TaiKhoan.fromJson(json['taiKhoan'])
          : null,
    );
  }

  // Chuyển object thành JSON
  Map<String, dynamic> toJson() {
    return {
      'MaNV': maNV,
      'HoTen': hoTen,
      'SDT': sdt,
      'Email': email,
      'MaTaiKhoan': maTaiKhoan,
      'taiKhoan': taiKhoan?.toJson(),
    };
  }
}