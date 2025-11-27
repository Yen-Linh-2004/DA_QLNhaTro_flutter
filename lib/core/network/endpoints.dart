class Endpoints {
  int kthueId = 1;
  static const String loaiPhong = "/admin/loai-phong";
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String logout = "/auth/logout";

  static const String khachthue = "/admin/khach-thue";
  static String khachThueId(int id) => "/admin/khach-thue/$id";
   
  static const String phongtro = "/admin/phong-tro";
  static const String dichvu = "/admin/dich-vu";
  static const String thietbi = "/admin/thiet-bi";
  static const String phongtrong = "/public/phong-trong";
}