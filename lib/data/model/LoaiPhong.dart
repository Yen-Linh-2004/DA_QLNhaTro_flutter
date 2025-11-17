import 'package:flutter_application/data/model/PhongTro.dart';

class LoaiPhong {
  final int maLoaiPhong;
  final String tenLoaiPhong;
  final double donGiaCoBan;
  final double? dienTich;
  final List<String>? tienNghi;
  final String? moTa;

  // Computed attributes
  final int tongSoPhong;
  final int soPhongTrong;
  final int soPhongDaThue;
  final int soPhongBaoTri;

  // Optional: Danh sách phòng (nếu API trả về nested)
  final List<PhongTro>? phongTro;

  LoaiPhong({
    required this.maLoaiPhong,
    required this.tenLoaiPhong,
    required this.donGiaCoBan,
    this.dienTich,
    this.tienNghi,
    this.moTa,
    this.tongSoPhong = 0,
    this.soPhongTrong = 0,
    this.soPhongDaThue = 0,
    this.soPhongBaoTri = 0,
    this.phongTro,
  });

  factory LoaiPhong.fromJson(Map<String, dynamic> json) {
    var tienNghiFromJson = json['TienNghi'];
    List<String>? tienNghiList;
    if (tienNghiFromJson != null && tienNghiFromJson is List) {
      tienNghiList = List<String>.from(tienNghiFromJson);
    }

    var phongTroFromJson = json['phongTro'];
    List<PhongTro>? phongTroList;
    if (phongTroFromJson != null && phongTroFromJson is List) {
      phongTroList =
          phongTroFromJson.map((e) => PhongTro.fromJson(e)).toList();
    }

    return LoaiPhong(
      maLoaiPhong: json['MaLoaiPhong'] ?? 0,
      tenLoaiPhong: json['TenLoaiPhong'] ?? '',
      donGiaCoBan: (json['DonGiaCoBan'] as num).toDouble(),
      dienTich: json['DienTich'] != null ? (json['DienTich'] as num).toDouble() : null,
      tienNghi: tienNghiList,
      moTa: json['MoTa'],
      tongSoPhong: json['TongSoPhong'] ?? 0,
      soPhongTrong: json['SoPhongTrong'] ?? 0,
      soPhongDaThue: json['SoPhongDaThue'] ?? 0,
      soPhongBaoTri: json['SoPhongBaoTri'] ?? 0,
      phongTro: phongTroList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaLoaiPhong': maLoaiPhong,
      'TenLoaiPhong': tenLoaiPhong,
      'DonGiaCoBan': donGiaCoBan,
      'DienTich': dienTich,
      'TienNghi': tienNghi,
      'MoTa': moTa,
      'TongSoPhong': tongSoPhong,
      'SoPhongTrong': soPhongTrong,
      'SoPhongDaThue': soPhongDaThue,
      'SoPhongBaoTri': soPhongBaoTri,
      'phongTro': phongTro?.map((e) => e.toJson()).toList(),
    };
  }
}
