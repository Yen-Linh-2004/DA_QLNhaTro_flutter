import 'package:flutter_application/Server/model/Khachthue.dart';
import 'package:flutter_application/Server/model/NhanVien.dart';

enum PhanLoaiBaoTriEnum { dien, nuoc, khac } 
enum MucDoUuTienBaoTriEnum { thap, trungBinh, cao }
enum TrangThaiBaoTriEnum { choPhanCong, dangXuLy, daHoanThanh }

class YeuCauBaoTri {
  final int maYeuCau;
  final int maKhachThue;
  final String tieuDe;
  final String moTa;
  final PhanLoaiBaoTriEnum phanLoai;
  final MucDoUuTienBaoTriEnum mucDoUuTien;
  final TrangThaiBaoTriEnum trangThai;
  final DateTime ngayYeuCau;
  final int? maNhanVienPhanCong;
  final DateTime? ngayPhanCong;
  final DateTime? ngayHoanThanh;
  final String? ghiChu;
  final double? chiPhiThucTe;
  final List<dynamic>? hinhAnhMinhChung; 

  final KhachThue? khachThue;
  final NhanVien? nhanVienPhanCong;

  YeuCauBaoTri({
    required this.maYeuCau,
    required this.maKhachThue,
    required this.tieuDe,
    required this.moTa,
    required this.phanLoai,
    required this.mucDoUuTien,
    required this.trangThai,
    required this.ngayYeuCau,
    this.maNhanVienPhanCong,
    this.ngayPhanCong,
    this.ngayHoanThanh,
    this.ghiChu,
    this.chiPhiThucTe,
    this.hinhAnhMinhChung,
    this.khachThue,
    this.nhanVienPhanCong,
  });

  factory YeuCauBaoTri.fromJson(Map<String, dynamic> json) {
    return YeuCauBaoTri(
      maYeuCau: json['MaYeuCau'] ?? 0,
      maKhachThue: json['MaKhachThue'] ?? 0,
      tieuDe: json['TieuDe'] ?? '',
      moTa: json['MoTa'] ?? '',
      phanLoai: _phanLoaiFromString(json['PhanLoai']),
      mucDoUuTien: _mucDoUuTienFromString(json['MucDoUuTien']),
      trangThai: _trangThaiFromString(json['TrangThai']),
      ngayYeuCau: DateTime.parse(json['NgayYeuCau']),
      maNhanVienPhanCong: json['MaNhanVienPhanCong'],
      ngayPhanCong: json['NgayPhanCong'] != null ? DateTime.parse(json['NgayPhanCong']) : null,
      ngayHoanThanh: json['NgayHoanThanh'] != null ? DateTime.parse(json['NgayHoanThanh']) : null,
      ghiChu: json['GhiChu'],
      chiPhiThucTe: json['ChiPhiThucTe'] != null ? (json['ChiPhiThucTe'] as num).toDouble() : null,
      hinhAnhMinhChung: json['HinhAnhMinhChung'] != null ? List<dynamic>.from(json['HinhAnhMinhChung']) : null,
      khachThue: json['KhachThue'] != null ? KhachThue.fromJson(json['KhachThue']) : null,
      nhanVienPhanCong: json['NhanVienPhanCong'] != null ? NhanVien.fromJson(json['NhanVienPhanCong']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaYeuCau': maYeuCau,
      'MaKhachThue': maKhachThue,
      'TieuDe': tieuDe,
      'MoTa': moTa,
      'PhanLoai': phanLoai.name,
      'MucDoUuTien': mucDoUuTien.name,
      'TrangThai': trangThai.name,
      'NgayYeuCau': ngayYeuCau.toIso8601String(),
      'MaNhanVienPhanCong': maNhanVienPhanCong,
      'NgayPhanCong': ngayPhanCong?.toIso8601String(),
      'NgayHoanThanh': ngayHoanThanh?.toIso8601String(),
      'GhiChu': ghiChu,
      'ChiPhiThucTe': chiPhiThucTe,
      'HinhAnhMinhChung': hinhAnhMinhChung,
      'KhachThue': khachThue?.toJson(),
      'NhanVienPhanCong': nhanVienPhanCong?.toJson(),
    };
  }

  static PhanLoaiBaoTriEnum _phanLoaiFromString(String? value) {
    switch (value) {
      case 'dien':
        return PhanLoaiBaoTriEnum.dien;
      case 'nuoc':
        return PhanLoaiBaoTriEnum.nuoc;
      case 'khac':
        return PhanLoaiBaoTriEnum.khac;
      default:
        return PhanLoaiBaoTriEnum.khac;
    }
  }

  static MucDoUuTienBaoTriEnum _mucDoUuTienFromString(String? value) {
    switch (value) {
      case 'thap':
        return MucDoUuTienBaoTriEnum.thap;
      case 'trungBinh':
        return MucDoUuTienBaoTriEnum.trungBinh;
      case 'cao':
        return MucDoUuTienBaoTriEnum.cao;
      default:
        return MucDoUuTienBaoTriEnum.thap;
    }
  }

  static TrangThaiBaoTriEnum _trangThaiFromString(String? value) {
    switch (value) {
      case 'choPhanCong':
        return TrangThaiBaoTriEnum.choPhanCong;
      case 'dangXuLy':
        return TrangThaiBaoTriEnum.dangXuLy;
      case 'daHoanThanh':
        return TrangThaiBaoTriEnum.daHoanThanh;
      default:
        return TrangThaiBaoTriEnum.choPhanCong;
    }
  }
}
