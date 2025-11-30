class DichVu {
  final int maDichVu;
  final String tenDichVu;
  final String? moTa;
  final double donGiaApDung;
  final String? donViTinh;
  final String danhMuc;
  final bool trangThaiHoatDong;
  final int? usageCount; 
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DichVu({
    required this.maDichVu,
    required this.tenDichVu,
    this.moTa,
    required this.donGiaApDung,
    this.donViTinh,
    required this.danhMuc,
    required this.trangThaiHoatDong,
    this.usageCount,
    this.createdAt,
    this.updatedAt,
  });

  // Tạo instance từ JSON
  factory DichVu.fromJson(Map<String, dynamic> json) {
    return DichVu(
      maDichVu: json['MaDichVu'] ?? 0,
      tenDichVu: json['TenDichVu'] ?? '',
      moTa: json['MoTa'],
      donGiaApDung: (json['DonGia'] != null)
          ? double.tryParse(json['DonGia'].toString()) ?? 0.0
          : 0.0,
      donViTinh: json['DonViTinh'],
      danhMuc: json['DanhMuc'] ?? 'Dịch vụ',
      trangThaiHoatDong: json['TrangThaiHoatDong'] ?? true,
      usageCount: json['usageCount'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  // Chuyển model sang JSON (ví dụ dùng cho POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'MaDichVu': maDichVu,
      'TenDichVu': tenDichVu,
      'MoTa': moTa,
      'DonGia': donGiaApDung,
      'DonViTinh': donViTinh,
      'DanhMuc': danhMuc,
      'TrangThaiHoatDong': trangThaiHoatDong,
    };
  }
}