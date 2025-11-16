enum TrangThaiPhongEnum { trong, daThue, baoTri }

class PhongTro {
  final int maPhong;
  final int maDay;
  final int? maLoaiPhong;
  final String tenPhong;
  final double? donGiaCoBan;
  final double? giaThueHienTai;
  final double? dienTich;
  final TrangThaiPhongEnum trangThai;
  final String? moTa;
  final String? hinhAnh;
  final List<dynamic>? tienNghi;

  // Quan hệ (có thể null nếu chưa load)
  final String? tenDay;
  final String? tenLoaiPhong;

  PhongTro({
    required this.maPhong,
    required this.maDay,
    this.maLoaiPhong,
    required this.tenPhong,
    this.donGiaCoBan,
    this.giaThueHienTai,
    this.dienTich,
    required this.trangThai,
    this.moTa,
    this.hinhAnh,
    this.tienNghi,
    this.tenDay,
    this.tenLoaiPhong,
  });

  factory PhongTro.fromJson(Map<String, dynamic> json) {
    return PhongTro(
      maPhong: json['MaPhong'] ?? 0,
      maDay: json['MaDay'] ?? 0,
      maLoaiPhong: json['MaLoaiPhong'],
      tenPhong: json['TenPhong'] ?? '',
      donGiaCoBan: json['DonGiaCoBan'] != null
          ? double.tryParse(json['DonGiaCoBan'].toString())
          : null,
      giaThueHienTai: json['GiaThueHienTai'] != null
          ? double.tryParse(json['GiaThueHienTai'].toString())
          : null,
      dienTich: json['DienTich'] != null
          ? double.tryParse(json['DienTich'].toString())
          : null,
      trangThai: _trangThaiFromString(json['TrangThai']),
      moTa: json['MoTa'],
      hinhAnh: json['HinhAnh'],
      tienNghi: json['TienNghi'] != null ? List.from(json['TienNghi']) : null,
      tenDay: json['TenDay'],
      tenLoaiPhong: json['TenLoaiPhong'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaPhong': maPhong,
      'MaDay': maDay,
      'MaLoaiPhong': maLoaiPhong,
      'TenPhong': tenPhong,
      'DonGiaCoBan': donGiaCoBan,
      'GiaThueHienTai': giaThueHienTai,
      'DienTich': dienTich,
      'TrangThai': trangThai.toString().split('.').last,
      'MoTa': moTa,
      'HinhAnh': hinhAnh,
      'TienNghi': tienNghi,
      'TenDay': tenDay,
      'TenLoaiPhong': tenLoaiPhong,
    };
  }

  static TrangThaiPhongEnum _trangThaiFromString(String? status) {
    switch (status) {
      case 'trong':
        return TrangThaiPhongEnum.trong;
      case 'daThue':
        return TrangThaiPhongEnum.daThue;
      case 'baoTri':
        return TrangThaiPhongEnum.baoTri;
      default:
        return TrangThaiPhongEnum.trong;
    }
  }
}
