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

  // Nested list
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
    // --- 1️⃣ Parse TienNghi an toàn ---
    List<String>? tienNghiList;
    if (json['TienNghi'] != null && json['TienNghi'] is List) {
      try {
        tienNghiList = List<String>.from(json['TienNghi']);
      } catch (e) {
        print("Lỗi parse TienNghi: $e");
      }
    }

    // --- 2️⃣ Parse phongTro an toàn ---
    List<PhongTro>? phongTroList;
    if (json['phongTro'] != null && json['phongTro'] is List) {
      try {
        phongTroList = (json['phongTro'] as List)
            .map((e) => PhongTro.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (e) {
        print("Lỗi parse phongTro: $e");
      }
    }

    // --- 3️⃣ Parse số/nullable an toàn ---
    double donGia = 0;
    if (json['DonGiaCoBan'] != null) {
      donGia = (json['DonGiaCoBan'] as num).toDouble();
    }

    double? dienTichVal;
    if (json['DienTich'] != null) {
      dienTichVal = (json['DienTich'] as num).toDouble();
    }

    return LoaiPhong(
      maLoaiPhong: json['MaLoaiPhong'] ?? 0,
      tenLoaiPhong: json['TenLoaiPhong'] ?? '',
      donGiaCoBan: donGia,
      dienTich: dienTichVal,
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
