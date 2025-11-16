import 'package:flutter/material.dart';

class InvoiceListPage extends StatelessWidget {
  const InvoiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text("Hóa đơn tháng 10/2025"),
                    _title("Hóa đơn tháng 10/2025"),
                    // Text("Hạn thanh toán: 05/11/2025"),

                    _item("Tiền thuê phòng", "1 tháng", "2.600.000đ"),
                    _divider(),
                    _item("Điện", "62 kWh", "217.000đ"),
                    _divider(),
                    _item("Nước", "2 người", "120.000đ"),
                    _divider(),
                    _item("Internet (gói cơ bản)", "1 phòng", "50.000đ"),
                    _divider(),
                    _item("Rác", "1 phòng", "40.000đ"),
                    _divider(),
                    _item("Gửi xe", "1 phòng", "100.000đ"),

                    const SizedBox(height: 20),
                    _title("Thông tin đọc số"),

                    _subInfo("Chỉ số điện", "1250 → 1312 kWh"),
                    SizedBox(height: 10),
                    _subInfo("Số người tính nước", "2 người"),
                    SizedBox(height: 10),
                    _subInfo("Gói Internet", "Internet 1 (50.000đ/tháng)"),

                    const SizedBox(height: 20),
                    // _title("Tổng hợp"),

                    const Divider(height: 24),
                    _total("Tạm tính", "3.127.000đ"),
                    _total("Công nợ kỳ trước", "0đ"),
                    _total("Giảm trừ", "0đ"),
                    _total("Phí trễ hạn", "0đ"),
                    _total("Cần thanh toán", "3.127.000đ", isBold: true),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // BUTTONS
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Thanh toán ngay",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 22,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Tải PDF"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------
  // WIDGETS
  // ------------------------------

  Widget _title(String text) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _item(String title, String unit, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(unit, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
        Text(
          price,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        )
      ],
    );
  }

  Widget _divider() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Divider(height: 1),
      );

  Widget _subInfo(String label, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 2),
          Text(value),          
        ],
      ),
    );
  }

  Widget _total(String label, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(
            amount,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          )
        ],
      ),
    );
  }
}
