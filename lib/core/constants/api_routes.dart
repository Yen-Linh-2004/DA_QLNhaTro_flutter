import 'package:flutter_application/data/service/AuthService.dart';
import 'package:flutter_application/data/service/LoaiPhongService.dart';

class ApiRoutes {
  static final loaiPhong = LoaiPhongService();
  static final auth = AuthService();
}