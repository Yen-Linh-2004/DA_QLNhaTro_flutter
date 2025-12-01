class DichVuPhong {
  final int maDichVuPhong;
  final int maPhong;
  final int maDichVu;
  final double donGiaApDung;
  final int? soLuong;
  final bool dangSuDung;
  final DateTime ngayBatDau;
  final DateTime? ngayKetThuc;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DichVuPhong({
    required this.maDichVuPhong,
    required this.maPhong,
    required this.maDichVu,
    required this.donGiaApDung,
    this.soLuong,
    required this.dangSuDung,
    required this.ngayBatDau,
    this.ngayKetThuc,
    this.createdAt,
    this.updatedAt,
  });

  factory DichVuPhong.fromJson(Map<String, dynamic> json) {
    return DichVuPhong(
      maDichVuPhong: json['MaDichVuPhong'] ?? 0,
      maPhong: json['MaPhong'] ?? 0,
      maDichVu: json['MaDichVu'] ?? 0,
      donGiaApDung: (json['DonGiaApDung'] != null)
          ? double.tryParse(json['DonGiaApDung'].toString()) ?? 0.0
          : 0.0,
      soLuong: json['SoLuong'],
      dangSuDung: json['DangSuDung'] ?? true,
      ngayBatDau: DateTime.parse(json['NgayBatDau']),
      ngayKetThuc: json['NgayKetThuc'] != null
          ? DateTime.tryParse(json['NgayKetThuc'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaDichVuPhong': maDichVuPhong,
      'MaPhong': maPhong,
      'MaDichVu': maDichVu,
      'DonGiaApDung': donGiaApDung,
      'SoLuong': soLuong,
      'DangSuDung': dangSuDung,
      'NgayBatDau': ngayBatDau.toIso8601String(),
      'NgayKetThuc': ngayKetThuc?.toIso8601String(),
    };
  }
}
