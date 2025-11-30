import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/Customer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../provider/CustomerProvider.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CustomerProvider>(context, listen: false).fetchInvoiceLast();
    });
  }

  String formatCurrency(double value) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: 'đ', decimalDigits: 0)
        .format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: Consumer<CustomerProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.InvoicesList.isEmpty) {
            return const Center(child: Text("Không có dữ liệu hóa đơn"));
          }

          final invoice = provider.InvoicesList.first;
          String removeDiacritics(String str) {
            const Map<String, String> accentMap = {
              'à':'a','á':'a','ả':'a','ã':'a','ạ':'a',
              'ă':'a','ằ':'a','ắ':'a','ẳ':'a','ẵ':'a','ặ':'a',
              'â':'a','ầ':'a','ấ':'a','ẩ':'a','ẫ':'a','ậ':'a',
              'è':'e','é':'e','ẻ':'e','ẽ':'e','ẹ':'e',
              'ê':'e','ề':'e','ế':'e','ể':'e','ễ':'e','ệ':'e',
              'ì':'i','í':'i','ỉ':'i','ĩ':'i','ị':'i',
              'ò':'o','ó':'o','ỏ':'o','õ':'o','ọ':'o',
              'ô':'o','ồ':'o','ố':'o','ổ':'o','ỗ':'o','ộ':'o',
              'ơ':'o','ờ':'o','ớ':'o','ở':'o','ỡ':'o','ợ':'o',
              'ù':'u','ú':'u','ủ':'u','ũ':'u','ụ':'u',
              'ư':'u','ừ':'u','ứ':'u','ử':'u','ữ':'u','ự':'u',
              'ỳ':'y','ý':'y','ỷ':'y','ỹ':'y','ỵ':'y',
              'đ':'d'
            };
            return str.split('').map((c) => accentMap[c] ?? c).join('');
          }
           final List<ChiTietHoaDonKhachThue> list = invoice.chiTietHoaDon ?? [];
          double getPrice(String key) {
            String keyClean = removeDiacritics(key.toLowerCase());
            return list
                .where((e) => removeDiacritics(e.noiDung.toLowerCase()).contains(keyClean))
                .map((e) => e.thanhTien.toDouble())   // chuyển int sang double
                .fold(0, (a, b) => a + b);
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // =========================
                  // HÓA ĐƠN
                  // =========================
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _title("Hóa đơn tháng ${invoice.thang}"),
                        _subInfo("Hạn thanh toán", invoice.ngayHetHan),

                        const SizedBox(height: 16),
                        // Hiển thị tất cả các hạng mục
                        ...invoice.chiTietHoaDon!.map((item) {
                          return Column(
                            children: [
                              _item(item.noiDung,
                                  item.soLuong % 1 == 0
                                      ? item.soLuong.toInt().toString()
                                      : item.soLuong.toString(),
                                  formatCurrency(item.thanhTien)),
                              _divider(),
                            ],
                          );
                        }).toList(),

                        // const SizedBox(height: 20),
                        // _title("Thông tin đọc số"),
                        // _subInfo("Chỉ số điện", "${invoice.chiTietHoaDon.} → ${invoice.chiSoDienMoi} kWh"),
                        // const SizedBox(height: 10),
                        // _subInfo("Số người tính nước", "${invoice.soNguoi} người"),
                        // const SizedBox(height: 10),
                        // _subInfo("Gói Internet", invoice.goInternet),

                        const SizedBox(height: 20),
                        const Divider(height: 24),

                        // Tổng kết
                        _total("Tạm tính", formatCurrency(invoice.tongTien)),
                        _total("Công nợ kỳ trước", formatCurrency(invoice.conLai)),
                        _total("Giảm trừ", formatCurrency(0)),
                        _total("Phí trễ hạn", formatCurrency(0)),
                        _total("Cần thanh toán", formatCurrency(invoice.conLai), isBold: true),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =========================
                  // BUTTONS
                  // =========================
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
          );
        },
      ),
    );
  }

  // ------------------------------
  // WIDGETS
  // ------------------------------

  Widget _title(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
