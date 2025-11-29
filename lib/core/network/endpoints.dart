class Endpoints {
  int kthueId = 1;
  static const String loaiPhong = "/admin/loai-phong";
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String logout = "/auth/logout";
  static const String phongtrong = "/public/phong-trong";

  static const String khachthue = "/admin/khach-thue";
  static String khachThueId(int id) => "/admin/khach-thue/$id";
  static const String phongtro = "/admin/phong-tro";
  static const String dichvu = "/admin/dich-vu";
  static const String thietbi = "/admin/thiet-bi";
  static const String noiquy = "/admin/noi-quy";
  static const String vipham = "/admin/vi-pham";
  static const String baotri = "/admin/yeu-cau-bao-tri";
  
  // CUSTOMER
  static const String invoices = "/customer/invoices";
  static const String invoiceslast = "/customer/invoices/latest";
  static const String room = "/customer/room";
  
}
  