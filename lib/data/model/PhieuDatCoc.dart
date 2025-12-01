
class PhieuDatCoc {
  final int maPhieuDatCoc;
  final int maPhong;
  final String hoTenNguoiDat;
  final String soDienThoaiNguoiDat;
  final String? emailNguoiDat;
  final String ngayDuKienVaoO;
  final double tienDatCoc;
  final String trangThai;
  final String? ghiChu;

  PhieuDatCoc({
    required this.maPhieuDatCoc,
    required this.maPhong,
    required this.hoTenNguoiDat,
    required this.soDienThoaiNguoiDat,
    this.emailNguoiDat,
    required this.ngayDuKienVaoO,
    required this.tienDatCoc,
    required this.trangThai,
    this.ghiChu,
  });

  factory PhieuDatCoc.fromJson(Map<String, dynamic> json) {
    return PhieuDatCoc(
      maPhieuDatCoc: _parseInt(json['MaPhieuDatCoc']),
      maPhong: _parseInt(json['MaPhong']),
      hoTenNguoiDat: json['HoTenNguoiDat'] ?? "",
      soDienThoaiNguoiDat: json['SoDienThoaiNguoiDat'] ?? "",
      emailNguoiDat: json['EmailNguoiDat'],
      ngayDuKienVaoO: json['NgayDuKienVaoO'] ?? "",
      tienDatCoc: _parseDouble(json['TienDatCoc']),
      trangThai: json['TrangThai'] ?? "",
      ghiChu: json['GhiChu'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaPhieuDatCoc': maPhieuDatCoc,
      'MaPhong': maPhong,
      'HoTenNguoiDat': hoTenNguoiDat,
      'SoDienThoaiNguoiDat': soDienThoaiNguoiDat,
      'EmailNguoiDat': emailNguoiDat,
      'NgayDuKienVaoO': ngayDuKienVaoO,
      'TienDatCoc': tienDatCoc,
      'TrangThai': trangThai,
      'GhiChu': ghiChu,
    };
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

}
