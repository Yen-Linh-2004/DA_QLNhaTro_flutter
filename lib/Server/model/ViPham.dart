import 'package:flutter_application/Server/model/Khachthue.dart';
import 'package:flutter_application/Server/model/NoiQuy.dart';

enum MucDoViPhamEnum { nhe, trungBinh, nang } // Cần map chính xác từ PHP
enum TrangThaiViPhamEnum { choGiaiQuyet, daGiaiQuyet, huy } // Cần map chính xác từ PHP

class ViPham {
  final int maViPham;
  final int maKhachThue;
  final String moTa;
  final MucDoViPhamEnum mucDo;
  final TrangThaiViPhamEnum trangThai;
  final DateTime ngayBaoCao;
  final DateTime? ngayGiaiQuyet;
  final String? ghiChu;
  final int maNoiQuy;

  final dynamic nguoiBaoCao; // Có thể là NhanVien hoặc KhachThue
  final KhachThue? khachThue;
  final NoiQuy? noiQuy;

  ViPham({
    required this.maViPham,
    required this.maKhachThue,
    required this.moTa,
    required this.mucDo,
    required this.trangThai,
    required this.ngayBaoCao,
    this.ngayGiaiQuyet,
    this.ghiChu,
    required this.maNoiQuy,
    this.nguoiBaoCao,
    this.khachThue,
    this.noiQuy,
  });

  factory ViPham.fromJson(Map<String, dynamic> json) {
    return ViPham(
      maViPham: json['MaViPham'] ?? 0,
      maKhachThue: json['MaKhachThue'] ?? 0,
      moTa: json['MoTa'] ?? '',
      mucDo: _mucDoFromString(json['MucDo']),
      trangThai: _trangThaiFromString(json['TrangThai']),
      ngayBaoCao: DateTime.parse(json['NgayBaoCao']),
      ngayGiaiQuyet: json['NgayGiaiQuyet'] != null ? DateTime.parse(json['NgayGiaiQuyet']) : null,
      ghiChu: json['GhiChu'],
      maNoiQuy: json['MaNoiQuy'] ?? 0,
      nguoiBaoCao: json['NguoiBaoCao'], // Tùy chỉnh mapping nếu cần
      khachThue: json['KhachThue'] != null ? KhachThue.fromJson(json['KhachThue']) : null,
      noiQuy: json['NoiQuy'] != null ? NoiQuy.fromJson(json['NoiQuy']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaViPham': maViPham,
      'MaKhachThue': maKhachThue,
      'MoTa': moTa,
      'MucDo': mucDo.name,
      'TrangThai': trangThai.name,
      'NgayBaoCao': ngayBaoCao.toIso8601String(),
      'NgayGiaiQuyet': ngayGiaiQuyet?.toIso8601String(),
      'GhiChu': ghiChu,
      'MaNoiQuy': maNoiQuy,
      'NguoiBaoCao': nguoiBaoCao, // Cần map nếu muốn chi tiết
      'KhachThue': khachThue?.toJson(),
      'NoiQuy': noiQuy?.toJson(),
    };
  }

  static MucDoViPhamEnum _mucDoFromString(String? value) {
    switch (value) {
      case 'nhe':
        return MucDoViPhamEnum.nhe;
      case 'trungBinh':
        return MucDoViPhamEnum.trungBinh;
      case 'nang':
        return MucDoViPhamEnum.nang;
      default:
        return MucDoViPhamEnum.nhe; // default
    }
  }

  static TrangThaiViPhamEnum _trangThaiFromString(String? value) {
    switch (value) {
      case 'choGiaiQuyet':
        return TrangThaiViPhamEnum.choGiaiQuyet;
      case 'daGiaiQuyet':
        return TrangThaiViPhamEnum.daGiaiQuyet;
      case 'huy':
        return TrangThaiViPhamEnum.huy;
      default:
        return TrangThaiViPhamEnum.choGiaiQuyet;
    }
  }
}
