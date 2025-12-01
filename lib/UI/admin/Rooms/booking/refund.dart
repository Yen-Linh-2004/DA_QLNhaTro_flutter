import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/PhieuDatCoc.dart';
import 'package:flutter_application/provider/PhieuDatCocProvider.dart';
import 'package:provider/provider.dart';

class RefundFullPage extends StatefulWidget {
  final int bookingId; // ID của booking cần hoàn tiền

  const RefundFullPage({super.key, required this.bookingId});

  @override
  State<RefundFullPage> createState() => _RefundFullPageState();
}

class _RefundFullPageState extends State<RefundFullPage> {
  PhieuDatCoc? booking;
  bool isLoading = true;
  String? selectedReason = "Chọn lý do";

  final List<String> reason = [
    "Chọn lý do",
    "Khách hàng hủy đặt phòng",
    "Phòng không còn trống",
    "Sự cố bảo trì",
    "Vi phạm chính sách",
    "Đặt phòng trùng lặp",
    "Lý do khác",
  ];

  final TextEditingController refundAmountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

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
      if (booking != null) {
        refundAmountController.text = booking!.tienDatCoc.toString();
      }
      isLoading = false;
    });
  }

  @override
  void dispose() {
    refundAmountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hoàn tiền đầy đủ",
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
                      // Thông tin đặt phòng
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F8FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Thông tin đặt phòng",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(height: 12),
                            _InfoRow(
                                label: "Khách hàng:",
                                value: booking!.hoTenNguoiDat),
                            _InfoRow(label: "Phòng:", value: booking!.maPhong.toString()),
                            _InfoRow(
                                label: "Tiền cọc gốc:",
                                value: "${booking!.tienDatCoc}đ",
                                valueColor: Colors.green),
                            _InfoRow(
                                label: "Ngày dự kiến vào ở:", value: booking!.ngayDuKienVaoO),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Số tiền hoàn
                      Text("Số tiền hoàn *"),
                      SizedBox(height: 8),
                      TextField(
                        controller: refundAmountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Nhập số tiền hoàn",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                          "Tối đa: ${booking!.tienDatCoc}đ",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      SizedBox(height: 20),

                      // Lý do hoàn tiền
                      Text("Lý do hoàn tiền *"),
                      SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedReason,
                        items: reason
                            .map((r) =>
                                DropdownMenuItem<String>(value: r, child: Text(r)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedReason = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Vui lòng chọn lý do hoàn tiền";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // Ghi chú thêm
                      Text("Ghi chú thêm"),
                      SizedBox(height: 8),
                      TextField(
                        controller: noteController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Nhập ghi chú...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),

                      // Tóm tắt hoàn tiền
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFCE8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tóm tắt hoàn tiền",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(height: 12),
                            _InfoRow(
                                label: "Tiền cọc gốc:",
                                value: "${booking!.tienDatCoc}đ"),
                            _InfoRow(
                                label: "Số tiền hoàn:",
                                value: refundAmountController.text,
                                valueColor: Colors.green),
                            _InfoRow(label: "Số tiền giữ lại:", value: "0đ", valueColor: Colors.red),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),

                      // Buttons
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
                                  padding:
                                      EdgeInsets.symmetric(vertical: 14)),
                              onPressed: () {
                                // TODO: Gọi API refund qua Provider
                              },
                              child: Text("Xác nhận hoàn tiền",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  _InfoRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.black87)),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: valueColor ?? Colors.black)),
        ],
      ),
    );
  }
}
