import 'package:flutter_application/data/model/Khachthue.dart';
import 'package:flutter_application/data/model/NoiQuy.dart';

enum MucDoViPhamEnum { nhe, vua, nghiem_trong, rat_nghiem_trong }
enum TrangThaiViPhamEnum { dang_xu_ly, da_xu_ly, da_canh_cao, huy }

class ViPham {
  final int maViPham;
  final String moTa;
  final MucDoViPhamEnum mucDo;
  final TrangThaiViPhamEnum trangThai;
  final DateTime ngayBaoCao;

  final DateTime? ngayGiaiQuyet;
  final String? ghiChu;

  final dynamic nguoiBaoCao;
  final KhachThue? khachThue;
  final NoiQuy? noiQuy;

  ViPham({
    required this.maViPham,
    required this.moTa,
    required this.mucDo,
    required this.trangThai,
    required this.ngayBaoCao,
    this.ngayGiaiQuyet,
    this.ghiChu,
    this.nguoiBaoCao,
    this.khachThue,
    this.noiQuy,
  });

  factory ViPham.fromJson(Map<String, dynamic> json) {
    return ViPham(
      maViPham: json['MaViPham'] ?? 0,
      moTa: json['MoTa'] ?? '',
      mucDo: _mucDoFromString(json['MucDo']),
      trangThai: _trangThaiFromString(json['TrangThai']),
      ngayBaoCao: _parseDate(json['NgayBaoCao']),
      ngayGiaiQuyet: (json['NgayGiaiQuyet'] != null && json['NgayGiaiQuyet'] != "")
          ? _parseDate(json['NgayGiaiQuyet'])
          : null,
      ghiChu: json['GhiChu'],
      nguoiBaoCao: json['nguoiBaoCao'],
      khachThue: json['khachThue'] != null ? KhachThue.fromJson(json['khachThue']) : null,
      noiQuy: json['noiQuy'] != null ? NoiQuy.fromJson(json['noiQuy']) : null,
    );
  }

  static DateTime _parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return DateTime.now(); // hoặc throw nếu muốn báo lỗi
    }
    final parts = dateString.split('/');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  static MucDoViPhamEnum _mucDoFromString(String? value) {
    switch (value) {
      case 'vua':
        return MucDoViPhamEnum.vua;
      case 'nghiem_trong':
        return MucDoViPhamEnum.nghiem_trong;
      case 'rat_nghiem_trong':
        return MucDoViPhamEnum.rat_nghiem_trong;
      default:
        return MucDoViPhamEnum.nhe;
    }
  }

  static TrangThaiViPhamEnum _trangThaiFromString(String? value) {
    switch (value) {
      case 'dang_xu_ly':
        return TrangThaiViPhamEnum.dang_xu_ly;
      case 'da_xu_ly':
        return TrangThaiViPhamEnum.da_xu_ly;
      case 'da_canh_cao':
        return TrangThaiViPhamEnum.da_canh_cao;
      case 'huy':
        return TrangThaiViPhamEnum.huy;
      default:
        return TrangThaiViPhamEnum.dang_xu_ly;
    }
  }
}
