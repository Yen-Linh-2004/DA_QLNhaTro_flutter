import 'package:flutter_application/data/model/NhomDichVu.dart';

class LoaiDichVu {
  final int maLoaiDV;
  final int maNhomDV;
  final String tenDichVu;
  final String? donViTinh;
  final double? donGiaMacDinh;

  // Relationship (optional)
  final NhomDichVu? nhomDichVu;

  LoaiDichVu({
    required this.maLoaiDV,
    required this.maNhomDV,
    required this.tenDichVu,
    this.donViTinh,
    this.donGiaMacDinh,
    this.nhomDichVu,
  });

  factory LoaiDichVu.fromJson(Map<String, dynamic> json) {
    return LoaiDichVu(
      maLoaiDV: json['MaLoaiDV'] ?? 0,
      maNhomDV: json['MaNhomDV'] ?? 0,
      tenDichVu: json['TenDichVu'] ?? '',
      donViTinh: json['DonViTinh'],
      donGiaMacDinh: json['DonGiaMacDinh'] != null
          ? (json['DonGiaMacDinh'] as num).toDouble()
          : null,
      nhomDichVu: json['nhomDichVu'] != null
          ? NhomDichVu.fromJson(json['nhomDichVu'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaLoaiDV': maLoaiDV,
      'MaNhomDV': maNhomDV,
      'TenDichVu': tenDichVu,
      'DonViTinh': donViTinh,
      'DonGiaMacDinh': donGiaMacDinh,
      'nhomDichVu': nhomDichVu?.toJson(),
    };
  }
}
