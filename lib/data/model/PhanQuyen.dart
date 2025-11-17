import 'package:flutter_application/data/model/TaiKhoan.dart';

class PhanQuyen {
  final int maQuyen;
  final String tenQuyen;
  final List<TaiKhoan>? taiKhoans;

  PhanQuyen({
    required this.maQuyen,
    required this.tenQuyen,
    this.taiKhoans,
  });

  factory PhanQuyen.fromJson(Map<String, dynamic> json) {
    return PhanQuyen(
      maQuyen: json['MaQuyen'] ?? 0,
      tenQuyen: json['TenQuyen'] ?? '',
      taiKhoans: json['taiKhoans'] != null
          ? List<TaiKhoan>.from(
              json['taiKhoans'].map((x) => TaiKhoan.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaQuyen': maQuyen,
      'TenQuyen': tenQuyen,
      'taiKhoans': taiKhoans?.map((x) => x.toJson()).toList(),
    };
  }
}
