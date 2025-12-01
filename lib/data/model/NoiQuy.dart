class NoiQuy {
  final int maNoiQuy;
  final String tieuDe;
  final String noiDung;
  final String phanLoai;
  final bool trangThai;

  NoiQuy({
    required this.maNoiQuy,
    required this.tieuDe,
    required this.noiDung,
    required this.phanLoai,
    required this.trangThai,
  });

  factory NoiQuy.fromJson(Map<String, dynamic> json) {
    return NoiQuy(
      maNoiQuy: json['MaNoiQuy'] ?? 0,
      tieuDe: json['TieuDe'] ?? '',
      noiDung: json['NoiDung'] ?? '',
      phanLoai: json['PhanLoai'] ?? '',
      trangThai: json['TrangThai'] is bool
          ? json['TrangThai']
          : json['TrangThai'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaNoiQuy': maNoiQuy,
      'TieuDe': tieuDe,
      'NoiDung': noiDung,
      'PhanLoai': phanLoai,
      'TrangThai': trangThai,
    };
  }
}
