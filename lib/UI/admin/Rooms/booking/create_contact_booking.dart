import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/PhieuDatCoc.dart';
import 'package:flutter_application/data/model/HopDong.dart';
import 'package:flutter_application/provider/PhieuDatCocProvider.dart';
import 'package:flutter_application/provider/HopDongProvider.dart';
import 'package:provider/provider.dart';

class CreateContractPage extends StatefulWidget {
  final int bookingId;

  const CreateContractPage({super.key, required this.bookingId});

  @override
  State<CreateContractPage> createState() => _CreateContractPageState();
}

class _CreateContractPageState extends State<CreateContractPage> {
  PhieuDatCoc? booking;
  bool isLoading = true;

  // Controllers
  late TextEditingController soHopDongCtrl;
  late TextEditingController tienCocCtrl;
  late TextEditingController ghiChuCtrl;

  // Ngày hợp đồng
  DateTime? ngayKy;
  DateTime? ngayBatDau;
  DateTime? ngayKetThuc;

  @override
  void initState() {
    super.initState();
    _loadBooking();
  }

  Future<void> _loadBooking() async {
    final provider = Provider.of<PhieuDatCocProvider>(context, listen: false);
    await provider.fetchPhieuDatCocById(widget.bookingId);

    setState(() {
      booking = provider.PhieuDatCocDetail;
      isLoading = false;

      soHopDongCtrl = TextEditingController();
      tienCocCtrl = TextEditingController(text: booking?.tienDatCoc.toString() ?? '');
      ghiChuCtrl = TextEditingController(text: booking?.ghiChu ?? '');
    });
  }

  Future<void> _pickDate(BuildContext context, DateTime? initialDate, Function(DateTime) onPicked) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (date != null) onPicked(date);
  }

  @override
  Widget build(BuildContext context) {
    final hopDongProvider = Provider.of<HopDongProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tạo hợp đồng từ đặt phòng",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : booking == null
              ? const Center(child: Text("Không tìm thấy dữ liệu đặt phòng"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Thông tin đặt phòng"),
                      _infoBox(children: [
                        _infoRow("Khách hàng:", booking!.hoTenNguoiDat),
                        _infoRow("Phòng:", booking!.maPhong.toString()),
                        _infoRow("Ngày nhận phòng:", booking!.ngayDuKienVaoO),
                      ]),

                      const SizedBox(height: 16),
                      _sectionTitle("Thông tin khách thuê & phòng"),
                      TextField(
                        decoration: _inputStyle("Khách thuê"),
                        controller: TextEditingController(text: booking!.hoTenNguoiDat),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<int>(
                        decoration: _inputStyle("Phòng"),
                        value: booking!.maPhong,
                        items: [
                          DropdownMenuItem(value: booking!.maPhong, child: Text(booking!.maPhong.toString())),
                        ],
                        onChanged: (value) {},
                      ),

                      const SizedBox(height: 16),
                      _sectionTitle("Chi tiết hợp đồng"),
                      TextField(
                        decoration: _inputStyle("Số hợp đồng"),
                        controller: soHopDongCtrl,
                      ),
                      const SizedBox(height: 12),
                      _datePickerField("Ngày ký hợp đồng", ngayKy, (date) => setState(() => ngayKy = date)),
                      const SizedBox(height: 12),
                      _datePickerField("Ngày bắt đầu", ngayBatDau, (date) => setState(() => ngayBatDau = date)),
                      const SizedBox(height: 12),
                      _datePickerField("Ngày kết thúc", ngayKetThuc, (date) => setState(() => ngayKetThuc = date)),
                      const SizedBox(height: 12),
                      TextField(
                        decoration: _inputStyle("Tiền cọc (VNĐ)"),
                        keyboardType: TextInputType.number,
                        controller: tienCocCtrl,
                      ),
                      const SizedBox(height: 12),
                      _sectionTitle("Ghi chú"),
                      TextField(
                        controller: ghiChuCtrl,
                        maxLines: 2,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Hủy"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: hopDongProvider.isLoading
                                  ? null
                                  : () async {
                                      if (ngayKy == null || ngayBatDau == null || ngayKetThuc == null) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text("Vui lòng chọn đầy đủ ngày hợp đồng")));
                                        return;
                                      }

                                      final hopDong = HopDong(
                                        maHopDong: booking!.maPhieuDatCoc!,
                                        soHopDong: soHopDongCtrl.text,
                                        ngayKy: ngayKy!,
                                        ngayBatDau: ngayBatDau!,
                                        ngayKetThuc: ngayKetThuc!,
                                        tienCoc: double.tryParse(tienCocCtrl.text) ?? 0,
                                        maPhong: booking!.maPhong,
                                        maKhachThue: 0,
                                        tienThueHangThang: 0,
                                        trangThai: 'active',
                                        ghiChu: ghiChuCtrl.text,
                                        hopDongDichVus: [],
                                      );

                                      try {
                                        await hopDongProvider.createHopDong(hopDong.toJson());
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text("Tạo hợp đồng thành công")));
                                        Navigator.pop(context);
                                      } catch (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Lỗi: ${e.toString()}")));
                                      }
                                    },
                              child: hopDongProvider.isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text(
                                      "Tạo hợp đồng",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }

  // ─────────────────────────── UI Helpers ───────────────────────────

  static Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      );

  static InputDecoration _inputStyle(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      );

  Widget _datePickerField(String label, DateTime? value, Function(DateTime) onPicked) => TextField(
        readOnly: true,
        controller: TextEditingController(
            text: value == null ? "" : "${value.day}/${value.month}/${value.year}"),
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onTap: () => _pickDate(context, value, onPicked),
      );

  static Widget _infoBox({required List<Widget> children}) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F8FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: children),
      );
}

class _infoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _infoRow(this.label, this.value, {this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color ?? Colors.black)),
        ],
      ),
    );
  }
}
