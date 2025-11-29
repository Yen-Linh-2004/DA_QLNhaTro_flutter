import 'package:flutter_application/data/model/DayTro.dart';
import 'package:flutter_application/data/model/PhongTro.dart';
class ThietBi {
  final int maThietBi;
  final String tenThietBi;
  final String? maThietBiCode;
  final String loaiThietBi;
  final int? maDay;
  final int? maPhong;
  final DateTime? ngayMua;
  final double? giaMua;
  final String tinhTrang;
  final DateTime? baoTriLanCuoi;
  final DateTime? baoTriLanSau;
  final String? baoHanh;
  final String? ghiChu;
  final String? hangSanXuat;
  final String? moTa;

  final DayTro? dayTro;
  final PhongTro? phongTro;

  ThietBi({
    required this.maThietBi,
    required this.tenThietBi,
    this.maThietBiCode,
    required this.loaiThietBi,
    this.maDay,
    this.maPhong,
    this.ngayMua,
    this.giaMua,
    required this.tinhTrang,
    this.baoTriLanCuoi,
    this.baoTriLanSau,
    this.baoHanh,
    this.ghiChu,
    this.hangSanXuat,
    this.moTa,
    this.dayTro,
    this.phongTro,
  });

  factory ThietBi.fromJson(Map<String, dynamic> json) {
    return ThietBi(
      maThietBi: json['MaThietBi'] ?? 0,
      tenThietBi: json['TenThietBi'] ?? '',
      maThietBiCode: json['MaThietBi_Code'],
      loaiThietBi: json['LoaiThietBi'] ?? '',
      maDay: json['MaDay'],
      maPhong: json['MaPhong'],
      ngayMua: json['NgayMua'] != null ? DateTime.parse(json['NgayMua']) : null,
      giaMua: (json['GiaMua'] is String)
        ? double.tryParse(json['GiaMua'])
        : (json['GiaMua'] as num?)?.toDouble(),
      tinhTrang: json['TinhTrang'] ?? '',
      baoTriLanCuoi: json['BaoTriLanCuoi'] != null ? DateTime.parse(json['BaoTriLanCuoi']) : null,
      baoTriLanSau: json['BaoTriLanSau'] != null ? DateTime.parse(json['BaoTriLanSau']) : null,
      baoHanh: json['BaoHanh'],
      ghiChu: json['GhiChu'],
      hangSanXuat: json['HangSanXuat'],
      moTa: json['MoTa'],
      dayTro: json['DayTro'] != null ? DayTro.fromJson(json['DayTro']) : null,
      phongTro: json['PhongTro'] != null ? PhongTro.fromJson(json['PhongTro']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaThietBi': maThietBi,
      'TenThietBi': tenThietBi,
      'MaThietBi_Code': maThietBiCode,
      'LoaiThietBi': loaiThietBi,
      'MaDay': maDay,
      'MaPhong': maPhong,
      'NgayMua': ngayMua?.toIso8601String(),
      'GiaMua': giaMua,
      'TinhTrang': tinhTrang,
      'BaoTriLanCuoi': baoTriLanCuoi?.toIso8601String(),
      'BaoTriLanSau': baoTriLanSau?.toIso8601String(),
      'BaoHanh': baoHanh,
      'GhiChu': ghiChu,
      'HangSanXuat': hangSanXuat,
      'MoTa': moTa,
      'DayTro': dayTro?.toJson(),
      'PhongTro': phongTro?.toJson(),
    };
  }
}
