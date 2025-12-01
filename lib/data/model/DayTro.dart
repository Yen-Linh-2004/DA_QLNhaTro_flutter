
import 'package:flutter_application/data/model/PhongTro.dart';

class DayTro {
  final int maDay;
  final String tenDay;
  final String? diaChi;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final List<PhongTro>? phongTro;

  DayTro({
    required this.maDay,
    required this.tenDay,
    this.diaChi,
    this.createdAt,
    this.updatedAt,
    this.phongTro,
  });

  factory DayTro.fromJson(Map<String, dynamic> json) {
    return DayTro(
      maDay: json['MaDay'] ?? 0,
      tenDay: json['TenDay'] ?? '',
      diaChi: json['DiaChi'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      phongTro: json['phongTro'] != null
          ? (json['phongTro'] as List)
              .map((item) => PhongTro.fromJson(item))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaDay': maDay,
      'TenDay': tenDay,
      'DiaChi': diaChi,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'phongTro': phongTro?.map((p) => p.toJson()).toList(),
    };
  }
}

