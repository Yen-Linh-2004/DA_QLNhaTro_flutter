class DichVuDangKy {
  final int maDVDangKy;
  final int maPhong;
  final int maLoaiDV;
  final double donGiaApDung;
  final int? soLuong;
  final bool trangThaiSuDung;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DichVuDangKy({
    required this.maDVDangKy,
    required this.maPhong,
    required this.maLoaiDV,
    required this.donGiaApDung,
    this.soLuong,
    required this.trangThaiSuDung,
    this.createdAt,
    this.updatedAt,
  });

  // Tạo instance từ JSON
  factory DichVuDangKy.fromJson(Map<String, dynamic> json) {
    return DichVuDangKy(
      maDVDangKy: json['MaDVDangKy'] ?? 0,
      maPhong: json['MaPhong'] ?? 0,
      maLoaiDV: json['MaLoaiDV'] ?? 0,
      donGiaApDung: (json['DonGiaApDung'] != null)
          ? double.tryParse(json['DonGiaApDung'].toString()) ?? 0.0
          : 0.0,
      soLuong: json['SoLuong'],
      trangThaiSuDung: json['TrangThaiSuDung'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  // Chuyển model sang JSON (dùng cho POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'MaDVDangKy': maDVDangKy,
      'MaPhong': maPhong,
      'MaLoaiDV': maLoaiDV,
      'DonGiaApDung': donGiaApDung,
      'SoLuong': soLuong,
      'TrangThaiSuDung': trangThaiSuDung,
    };
  }
}