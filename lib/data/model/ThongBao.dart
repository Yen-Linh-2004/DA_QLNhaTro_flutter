import 'package:intl/intl.dart';

class ThongBao {
  final int maThongBao;
  final String tieuDe;
  final String noiDung;
  final String loai;
  final String doiTuongNhan;
  final List<int>? cacPhongNhan;
  final String trangThai;
  final DateTime? thoiGianGui;
  final DateTime? thoiGianHenGio;
  final DateTime? thoiGianTao;
  final int soNguoiDoc;
  final int tongSoNguoiNhan;
  final List<ChiTietThongBao>? chiTiet; // danh sách chi tiết thông báo

  ThongBao({
    required this.maThongBao,
    required this.tieuDe,
    required this.noiDung,
    required this.loai,
    required this.doiTuongNhan,
    this.cacPhongNhan,
    required this.trangThai,
    this.thoiGianGui,
    this.thoiGianHenGio,
    this.thoiGianTao,
    required this.soNguoiDoc,
    required this.tongSoNguoiNhan,
    this.chiTiet,
  });

  factory ThongBao.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? value) {
      if (value == null) return null;
      try {
        return DateFormat("dd/MM/yyyy HH:mm").parse(value);
      } catch (e) {
        return null;
      }
    }

    return ThongBao(
      maThongBao: json['MaThongBao'] ?? 0,
      tieuDe: json['TieuDe'] ?? '',
      noiDung: json['NoiDung'] ?? '',
      loai: json['LoaiThongBao'] ?? '',
      doiTuongNhan: json['DoiTuongNhan'] ?? '',
      cacPhongNhan: json['CacPhongNhan'] != null
          ? List<int>.from(json['CacPhongNhan'])
          : null,
      trangThai: json['TrangThai'] ?? '',
      thoiGianGui: parseDate(json['ThoiGianGui']),
      thoiGianHenGio: parseDate(json['ThoiGianHenGio']),
      thoiGianTao: parseDate(json['ThoiGianTao']),
      soNguoiDoc: json['SoNguoiDoc'] ?? 0,
      tongSoNguoiNhan: json['TongSoNguoiNhan'] ?? 0,
      chiTiet: json['ChiTietThongBao'] != null
          ? (json['ChiTietThongBao'] as List)
              .map((e) => ChiTietThongBao.fromJson(e))
              .toList()
          : null,
    );
  }
}

class ChiTietThongBao {
  final int maChiTiet;
  final String trangThaiDoc;
  final DateTime? thoiGianDoc;

  ChiTietThongBao({
    required this.maChiTiet,
    required this.trangThaiDoc,
    this.thoiGianDoc,
  });

  factory ChiTietThongBao.fromJson(Map<String, dynamic> json) {
    return ChiTietThongBao(
      maChiTiet: json['MaChiTiet'] ?? 0,
      trangThaiDoc: json['TrangThaiDoc'] ?? '',
      thoiGianDoc: json['ThoiGianDoc'] != null
          ? DateFormat("dd/MM/yyyy HH:mm").parse(json['ThoiGianDoc'])
          : null,
    );
  }
}
