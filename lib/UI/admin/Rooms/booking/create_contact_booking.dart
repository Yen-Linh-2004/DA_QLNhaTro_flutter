import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/PhieuDatCoc.dart';
import 'package:flutter_application/provider/PhieuDatCocProvider.dart';
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tạo hợp đồng từ đặt phòng",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : booking == null
              ? Center(child: Text("Không tìm thấy dữ liệu đặt phòng"))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Thông tin đặt phòng"),
                      _infoBox(children: [
                        _infoRow("Khách hàng:", booking!.hoTenNguoiDat),
                        _infoRow("Phòng:", booking!.maPhong.toString()),
                        _infoRow("Ngày nhận phòng:", booking!.ngayDuKienVaoO),
                      ]),

                      SizedBox(height: 16),
                      _sectionTitle("Thông tin khách thuê & phòng"),
                      TextField(
                        decoration: _inputStyle("Khách thuê"),
                        controller: TextEditingController(text: booking!.hoTenNguoiDat),
                      ),
                      SizedBox(height: 12),
                      DropdownButtonFormField(
                        decoration: _inputStyle("Phòng"),
                        value: booking!.maPhong,
                        items: [
                          DropdownMenuItem(value: booking!.maPhong, child: Text(booking!.maPhong.toString())),
                          // Thêm các phòng khác nếu cần
                        ],
                        onChanged: (value) {},
                      ),

                      SizedBox(height: 16),
                      _sectionTitle("Chi tiết hợp đồng"),
                      TextField(
                        decoration: _inputStyle("Số hợp đồng"),
                      ),
                      SizedBox(height: 12),
                      _datePickerField("Ngày ký hợp đồng"),
                      SizedBox(height: 12),
                      _datePickerField("Ngày bắt đầu"),
                      SizedBox(height: 12),
                      _datePickerField("Ngày kết thúc"),
                      SizedBox(height: 12),
                      TextField(
                        decoration: _inputStyle("Tiền cọc (VNĐ)"),
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(text: booking!.tienDatCoc.toString()),
                      ),

                      SizedBox(height: 20),
                      _sectionTitle("Thông tin phòng"),
                      _infoBox(children: [
                        _infoRow("Tiền thuê:", "${booking!.tienDatCoc ?? 'Chưa xác định'}"),
                        _infoRow("Tiền cọc:", "${booking!.tienDatCoc}"),
                        // Thêm các thông tin khác nếu API cung cấp
                      ]),

                      SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Hủy"),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                padding: EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () {
                                // Gửi dữ liệu tạo hợp đồng lên API
                              },
                              child: Text(
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
        padding: EdgeInsets.only(bottom: 8),
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      );

  static InputDecoration _inputStyle(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      );

  static Widget _datePickerField(String label) => TextField(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        readOnly: true,
      );

  static Widget _infoBox({required List<Widget> children}) => Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFF4F8FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: children),
      );
}

class _infoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  _infoRow(this.label, this.value, {this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
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
