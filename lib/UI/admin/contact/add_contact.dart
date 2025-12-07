import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/KhachThue.dart';
import 'package:flutter_application/provider/HopDongProvider.dart';
import 'package:flutter_application/provider/PhieuDatCocProvider.dart';
import 'package:flutter_application/provider/PhongTroProvider.dart';
import 'package:flutter_application/provider/khachthueProvider.dart';
import 'package:provider/provider.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  // Controllers
  // final _tenKhachThue = TextEditingController(text: "Nguyễn Ngọc Lan");
  final _soHopDong = TextEditingController(text: "HD005");
  final _ngayBatDau = TextEditingController(text: "01/01/2025");
  final _ngayKy = TextEditingController(text: "01/11/2025");
  final _ngayKetThuc = TextEditingController(text: "01/11/2025");
  final _tienThue = TextEditingController(text: "1500000");
  final _tienCoc = TextEditingController(text: "3000000");
  final TextEditingController _amenities = TextEditingController();
  String? selectedRoomId;
  String? selectedCustomerId;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PhongTroProvider>(context, listen: false).fetchPhongTrong();
      Provider.of<PhieuDatCocProvider>(context, listen: false).fetchPhieuDatCoc();
    });
  }

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<PhongTroProvider>(context);
    final phieuDatCocProvider = Provider.of<PhieuDatCocProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tạo hợp đồng",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // ======================
            // SỐ HỢP ĐỒNG
            // ======================
            buildTitle("Số hợp đồng"),
            buildInput(_soHopDong, "Nhập tên số hợp đồng"),

            // ======================
            // KHÁCH THUÊ
            // ======================
            buildTitle("Khách thuê"),
            phieuDatCocProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildDropdownMap(
                    value: selectedCustomerId,
                    items: phieuDatCocProvider.PhieuDatCocList
                        .map((khachthue) => {
                              'id': khachthue.maPhieuDatCoc.toString(),
                              'name': khachthue.hoTenNguoiDat
                            })
                        .toList(),
                    onChanged: (v) => setState(() => selectedCustomerId = v),
                    hint: "Chọn khách thuê",
                  ),

            // ======================
            // NGÀY BẮT ĐẦU
            // ======================
            buildTitle("Ngày bắt đầu"),
            buildInput(_ngayBatDau, "dd/MM/yyyy"),

            // ======================
            // NGÀY KÝ
            // ======================
            buildTitle("Ngày ký"),
            buildInput(_ngayKy, "dd/MM/yyyy"),

            // ======================
            // NGÀY KẾT THÚC
            // ======================
            buildTitle("Ngày kết thúc"),
            buildInput(_ngayKetThuc, "dd/MM/yyyy"),

            // ======================
            // PHÒNG
            // ======================
            buildTitle("Phòng"),
            roomProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildDropdownMap(
                    value: selectedRoomId,
                    items: roomProvider.phongTrongList
                        .map((room) => {
                              'id': room.maPhong.toString(),
                              'name': room.tenPhong
                            })
                        .toList(),
                    onChanged: (v) => setState(() => selectedRoomId = v),
                    hint: "Chọn phòng trống",
                  ),
            // ======================
            // TIỀN THUÊ
            // ======================
            buildTitle("Tiền thuê (VNĐ)"),
            buildInput(_tienThue, "Nhập tiền thuê"),

            // ======================
            // TIỀN CỌC
            // ======================
            buildTitle("Tiền cọc (VNĐ)"),
            buildInput(_tienCoc, "Nhập tiền cọc"),

            // ======================
            // TIỆN NGHI
            // ======================
            buildTitle("Tiện nghi"),
             buildInput(_amenities, "VD: wifi, máy lạnh, giường"),

            const SizedBox(height: 20),

            // ======================
            // BUTTONS
            // ======================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildButton(Icons.close, "Hủy", Colors.red, () {
                  Navigator.pop(context);
                }),
                buildButton(Icons.add, "Tạo hợp đồng", Colors.green, () async {
                List<String> amenList = _amenities.text
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList();

                  final data = {
                    "SoHopDong": _soHopDong.text.trim(),
                    "MaPhong": selectedRoomId,
                    "maKhachThue": selectedCustomerId,
                    "NgayKy": _ngayKy.text.trim(),
                    "NgayBatDau": _ngayBatDau.text.trim(),
                    "NgayKetThuc": _ngayKetThuc.text.trim(),
                    "TienCoc": double.tryParse(_tienCoc.text) ?? 0,
                    "TienThueHangThang": double.tryParse(_tienThue.text) ?? 0,
                    "TrangThai": "Đang hiệu lực",
                    "GhiChu": null,
                    "SoLanGiaHan": 0,
                    "hopDongDichVus": [],
                  };
                  print("📌 DATA GỬI: $data");
                  await Provider.of<HopDongProvider>(context, listen: false)
                      .createHopDong(data);

                  Navigator.pop(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ======================
  // TIỆN ÍCH TÁCH RIÊNG
  // ======================
  Widget buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }

  Widget buildInput(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint,
      ),
    );
  }

  Widget buildButton(IconData icon, String text, Color color, VoidCallback onTap) {
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        icon: Icon(icon, color: Colors.white),
        onPressed: onTap,
        label: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
  
    Widget _buildDropdownMap({
    required String? value,
    required List<Map<String, dynamic>> items,
    required Function(String?) onChanged,
    required String hint,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint),
          isExpanded: true,
          onChanged: onChanged,
          items: items
              .map((e) => DropdownMenuItem<String>(
                    value: e['id'].toString(),
                    child: Text(e['name']),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
