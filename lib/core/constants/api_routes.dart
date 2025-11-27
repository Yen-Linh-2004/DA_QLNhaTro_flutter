import 'package:flutter_application/data/model/PhongTro.dart';
import 'package:flutter_application/data/service/AuthService.dart';
import 'package:flutter_application/data/service/DichVuSerrvice.dart';
import 'package:flutter_application/data/service/LoaiPhongService.dart';
import 'package:flutter_application/data/service/PhongTroService.dart';
import 'package:flutter_application/data/service/ThietBiService.dart';
import 'package:flutter_application/data/service/khachThueService.dart';

class ApiRoutes {
  static final loaiPhong = LoaiPhongService();
  static final auth = AuthService();
  static final khachthue = KhachThueService();
  static final phongtro = PhongtroService();
  static final dichvu = DichvuSerrvice();
  static final thietbi = ThietBiService();
}