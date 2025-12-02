class Endpoints {
  static const String loaiPhong = "/admin/loai-phong";
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String logout = "/auth/logout";
  static const String phongtrong = "/public/phong-trong";
  static const String khachthue = "/admin/khach-thue";
  static const String phongtro = "/admin/phong-tro";
  static const String dichvu = "/admin/dich-vu";
  static const String thietbi = "/admin/thiet-bi";
  static const String noiquy = "/admin/noi-quy";
  static const String vipham = "/admin/vi-pham";
  static const String baotri = "/admin/yeu-cau-bao-tri";
  static const String hopdong = "/admin/hop-dong";
  static const String thongbao = "/admin/thong-bao";
  static const String thongbaohethong = "/admin/thong-bao-he-thong";
  static const String taikhoan = "/admin/tai-khoan";
  static const String phieudatcoc = "/admin/phieu-dat-coc";

  // CUSTOMER
  static const String invoices = "/customer/invoices";
  static const String invoiceslast = "/customer/invoices/latest";
  static const String room = "/customer/room";
  static const String contract = "/customer/contract";
  static const String roomStatus = "/customer/room-status";

  static String khachThueId(int id) => "/admin/khach-thue/$id";
  static String phongtroId(int id) => "/admin/phong-tro/$id";
  static String hopdongId(int id) => "/admin/hop-dong/$id";
  static String phieudatcocId(int id) => "/admin/phieu-dat-coc/$id";
  static String dichvuId(int id) => "/admin/dich-vu/$id";
  static String thietbiId(int id) => "/admin/thiet-bi/$id";
  // static const String baotri = "/admin/yeu-cau-bao-tri";
  // static const String hopdong = "/admin/hop-dong";

}
  