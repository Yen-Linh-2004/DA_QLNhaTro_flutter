
import 'package:flutter_application/data/model/LoaiDichVu.dart';

class NhomDichVu {
  final int maNhomDV;
  final String tenNhomDV;
  final String loaiPhatSinh;
  final String? phuThuocVao;

  // Danh sách loại dịch vụ thuộc nhóm này
  final List<LoaiDichVu>? loaiDichVu;

  NhomDichVu({
    required this.maNhomDV,
    required this.tenNhomDV,
    required this.loaiPhatSinh,
    this.phuThuocVao,
    this.loaiDichVu,
  });

  factory NhomDichVu.fromJson(Map<String, dynamic> json) {
    return NhomDichVu(
      maNhomDV: json['MaNhomDV'] ?? 0,
      tenNhomDV: json['TenNhomDV'] ?? '',
      loaiPhatSinh: json['LoaiPhatSinh'] ?? '',
      phuThuocVao: json['PhuThuocVao'],
      loaiDichVu: json['loaiDichVu'] != null
          ? (json['loaiDichVu'] as List)
              .map((e) => LoaiDichVu.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaNhomDV': maNhomDV,
      'TenNhomDV': tenNhomDV,
      'LoaiPhatSinh': loaiPhatSinh,
      'PhuThuocVao': phuThuocVao,
      'loaiDichVu': loaiDichVu?.map((e) => e.toJson()).toList(),
    };
  }
}
