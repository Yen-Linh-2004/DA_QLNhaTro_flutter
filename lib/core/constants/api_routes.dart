import 'package:flutter_application/data/service/AuthService.dart';
import 'package:flutter_application/data/service/BaoTriService.dart';
import 'package:flutter_application/data/service/CustomerService.dart';
import 'package:flutter_application/data/service/DichVuSerrvice.dart';
import 'package:flutter_application/data/service/HopDongService.dart';
import 'package:flutter_application/data/service/LoaiPhongService.dart';
import 'package:flutter_application/data/service/NoiQuyService.dart';
import 'package:flutter_application/data/service/PhieuDatCocService.dart';
import 'package:flutter_application/data/service/PhongTroService.dart';
import 'package:flutter_application/data/service/TaiKhoanService.dart';
import 'package:flutter_application/data/service/ThietBiService.dart';
import 'package:flutter_application/data/service/ThongBaoService.dart';
import 'package:flutter_application/data/service/ViPhamService.dart';
import 'package:flutter_application/data/service/khachThueService.dart';

class ApiRoutes {
  static final loaiPhong = LoaiPhongService();
  static final auth = AuthService();
  static final khachthue = KhachThueService();
  static final phongtro = PhongtroService();
  static final dichvu = DichvuSerrvice();
  static final thietbi = ThietBiService();
  static final noiquy = NoiQuyService();
  static final vipham = ViPhamService();
  static final baotri = BaoTriService();
  static final hopdong = HopDongSerrvice();
  static final thongbao = ThongBaoSerrvice();
  static final taikhoan = TaiKhoanSerrvice();
  static final phieudatcoc = PhieuDatCocSerrvice();
  static final customer = CustomerSerrvice();
}