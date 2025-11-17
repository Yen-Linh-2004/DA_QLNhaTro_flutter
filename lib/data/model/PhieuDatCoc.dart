
enum TrangThaiPhieuDatCocEnum { dangCho, daXacNhan, daHuy }

class PhieuDatCoc {
  final int maPhieuDatCoc;
  final int maPhong;
  final String hoTenNguoiDat;
  final String? soDienThoaiNguoiDat;
  final String? emailNguoiDat;
  final DateTime? ngayDuKienVaoO;
  final int tienDatCoc;
  final TrangThaiPhieuDatCocEnum trangThai;
  final String? ghiChu;

  PhieuDatCoc({
    required this.maPhieuDatCoc,
    required this.maPhong,
    required this.hoTenNguoiDat,
    this.soDienThoaiNguoiDat,
    this.emailNguoiDat,
    this.ngayDuKienVaoO,
    required this.tienDatCoc,
    required this.trangThai,
    this.ghiChu,
  });

  factory PhieuDatCoc.fromJson(Map<String, dynamic> json) {
    return PhieuDatCoc(
      maPhieuDatCoc: json['MaPhieuDatCoc'] ?? 0,
      maPhong: json['MaPhong'] ?? 0,
      hoTenNguoiDat: json['HoTenNguoiDat'] ?? '',
      soDienThoaiNguoiDat: json['SoDienThoaiNguoiDat'],
      emailNguoiDat: json['EmailNguoiDat'],
      ngayDuKienVaoO: json['NgayDuKienVaoO'] != null
          ? DateTime.parse(json['NgayDuKienVaoO'])
          : null,
      tienDatCoc: json['TienDatCoc'] != null
          ? int.parse(json['TienDatCoc'].toString())
          : 0,
      trangThai: _trangThaiFromString(json['TrangThai']),
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
      'NgayDuKienVaoO': ngayDuKienVaoO?.toIso8601String(),
      'TienDatCoc': tienDatCoc,
      'TrangThai': trangThai.toString().split('.').last,
      'GhiChu': ghiChu,
    };
  }

  static TrangThaiPhieuDatCocEnum _trangThaiFromString(String? status) {
    switch (status) {
      case 'dangCho':
        return TrangThaiPhieuDatCocEnum.dangCho;
      case 'daXacNhan':
        return TrangThaiPhieuDatCocEnum.daXacNhan;
      case 'daHuy':
        return TrangThaiPhieuDatCocEnum.daHuy;
      default:
        return TrangThaiPhieuDatCocEnum.dangCho;
    }
  }
}
