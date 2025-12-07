import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/provider/PhieuDatCocProvider.dart';
import 'package:flutter_application/provider/PhongTroProvider.dart';
import 'package:provider/provider.dart';

class CreateBookingPage extends StatefulWidget {
  const CreateBookingPage({super.key});

  @override
  State<CreateBookingPage> createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final depositCtrl = TextEditingController();
  final noteCtrl = TextEditingController();
  final time = TextEditingController();

  String? selectedRoomId;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PhongTroProvider>(context, listen: false).fetchPhongTrong();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<PhieuDatCocProvider>(context);
    final roomProvider = Provider.of<PhongTroProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tạo đặt phòng mới",
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
            const Text("Thông tin khách hàng",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildLabel("Họ tên"),
            _buildInput(nameCtrl, hint: "vd: Nguyễn Văn A"),
            _buildLabel("Số điện thoại"),
            _buildInput(phoneCtrl,
                hint: "vd: 0901234567", keyboard: TextInputType.phone),
            _buildLabel("Email"),
            _buildInput(emailCtrl,
                hint: "vd: email@example.com",
                keyboard: TextInputType.emailAddress),
            const SizedBox(height: 12),
            const Text("Thông tin đặt phòng",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildLabel("Phòng"),

            // === Dropdown phòng với FutureBuilder ===
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

            _buildLabel("Ngày nhận phòng"),
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2035),
                );
                if (date != null) setState(() => selectedDate = date);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? "mm/dd/yyyy"
                          : "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}",
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Icon(Icons.calendar_today_outlined, size: 18),
                  ],
                ),
              ),
            ),
            _buildLabel("Thời hạn thuê (tháng)"),
              _buildInput(time,  hint: "vd: 6 tháng, 1 năm", keyboard: TextInputType.number),

            _buildLabel("Tiền cọc (VND)"),
            _buildInput(depositCtrl,
                hint: "7000000", keyboard: TextInputType.number),
            _buildLabel("Ghi chú"),
            _buildInput(noteCtrl,
                hint: "Nhập ghi chú (tùy chọn)", keyboard: TextInputType.text),
            const SizedBox(height: 20),
            Row(
              children: [
                buildActionBtn(Icons.close, "Hủy", Colors.red,
                    () => Navigator.pop(context)),
                const SizedBox(width: 12),
                bookingProvider.isLoading
                    ? const CircularProgressIndicator()
                    : buildActionBtn(Icons.add, "Tạo đặt phòng", Colors.blue,
                        () async {
                        if (selectedRoomId == null || selectedDate == null ) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text( "Vui lòng chọn đầy đủ thông tin phòng, ngày và thời hạn")));
                          return;
                        }

                        final data = {
                          "HoTenNguoiDat": nameCtrl.text,
                          "SoDienThoaiNguoiDat": phoneCtrl.text,
                          "Email": emailCtrl.text,
                          "MaPhong": selectedRoomId,
                          "NgayDuKienVaoO": selectedDate?.toIso8601String(),
                          "ThoiHanThue": time.text,
                          "TienDatCoc": int.tryParse(depositCtrl.text) ?? 0,
                          "GhiChu": noteCtrl.text,
                        };

                        try {
                          await bookingProvider.createPhieuDatPhong(data);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Tạo phiếu đặt phòng thành công")));
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Lỗi: ${e.toString()}")));
                        }
                      }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 14),
      child:
          Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildInput(TextEditingController controller,
      {String? hint, TextInputType keyboard = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
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
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
        ),
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
