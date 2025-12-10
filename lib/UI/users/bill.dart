import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/data/model/HoaDon.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../provider/CustomerProvider.dart';
import '../../data/model/Customer.dart'; // sửa nếu model nằm folder khác

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final provider = Provider.of<CustomerProvider>(context, listen: false);
      await provider.fetchInvoice();
    });
  }

  // ================== FORMAT ===================
  String formatCurrency(num value) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: 'đ', decimalDigits: 0)
        .format(value);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CustomerProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.InvoicesList.isEmpty) {
            return const Center(child: Text("Không có hóa đơn"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.InvoicesList.length,
            itemBuilder: (context, index) {
              final invoice = provider.InvoicesList[index];
              return _invoiceCard(invoice);
            },
          );
        },
      ),
    );
  }

  // ================== INVOICE CARD ===================
  Widget _invoiceCard(HoaDonKhachThue invoice) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hóa Đơn ${invoice.thang ?? ""}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          Text(
            "Ngày lập: ${invoice.ngayLap != null ? formatDate(DateTime.parse(invoice.ngayLap)) : "Chưa cập nhật"}",
            style: const TextStyle(color: Colors.grey),
          ),

          Text(
            "Ngày hết hạn: ${invoice.ngayHetHan != null ? formatDate(DateTime.parse(invoice.ngayHetHan)) : "Chưa cập nhật"}",
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),

          _rowItem("Tổng tiền", formatCurrency(invoice.tongTien)),
          const SizedBox(height: 6),
          _rowItem("Còn lại", formatCurrency(invoice.conLai),
              isBold: true),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.receipt_long),
              label: const Text("Xem chi tiết"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BillDetailPage(invoice: invoice),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowItem(String left, String right, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(right,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}

// ============================================================
// ================  BILL DETAIL PAGE  ========================
// ============================================================
class BillDetailPage extends StatefulWidget {
  final HoaDonKhachThue invoice;
  const BillDetailPage({super.key, required this.invoice});

  @override
  State<BillDetailPage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<BillDetailPage> {
 @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final provider = Provider.of<CustomerProvider>(context, listen: false);
      await provider.fetchInvoice(); 
    });
  }

  String formatCurrency(double value) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: 'đ', decimalDigits: 0)
        .format(value);
  }

  String formatDate(DateTime date) {
    final formatter = DateFormat('dd/MM/yyyy'); 
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f4f9),

      body: Consumer<CustomerProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.InvoicesList.isEmpty) {
            return const Center(child: Text("Không có hóa đơn"));
          }

          final invoice = provider.InvoicesList.first;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------------- HEADER ----------------
                Text(
                  'Hóa Đơn ${invoice.thang ?? ""}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text('Ngày lập: ${invoice.ngayLap != null ? formatDate(DateTime.parse(invoice.ngayLap)) : "Chưa cập nhật"}',),

                const SizedBox(height: 4),
               Text('Ngày hết hạn: ${invoice.ngayHetHan != null ? formatDate(DateTime.parse(invoice.ngayHetHan)) : "Chưa cập nhật"}',),

                const SizedBox(height: 25),

                // ---------------- ITEMS ----------------
                ..._buildBillItems(invoice),

                const SizedBox(height: 25),
                const Divider(),
                const SizedBox(height: 12),

                _buildRow("Tạm tính", formatCurrency(invoice.tongTien ?? 0), isBold: true),
                const SizedBox(height: 10),
                _buildRow("Đã thanh toán", formatCurrency(invoice.tongTien ?? 0)),
                const SizedBox(height: 10),
                _buildRow("Giảm trừ", formatCurrency(0)),
                const SizedBox(height: 10),
                _buildRow("Phí trễ hạn", formatCurrency(0)),

                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),

                _buildRow("Cần thanh toán", formatCurrency(invoice.conLai ?? 0), isBold: true),

                const SizedBox(height: 30),

                // ---------------- BUTTONS ----------------
                Row(
                  children: [
                    buildActionBtn(Icons.payment, "Thanh toán ngay", Colors.blue, () {}),
                    SizedBox(width: 10),
                    buildActionBtn(Icons.picture_as_pdf, "Tải PDF", Colors.green, () {}),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===================== BILL ITEMS LIST ======================
  List<Widget> _buildBillItems(invoice) {
  final List<ChiTietHoaDonKhachThue> list = invoice.chiTietHoaDon ?? [];

  // ===== REMOVE DIACRITICS AN TOÀN =====
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

  // ===== GET PRICE AN TOÀN =====
double getPrice(String key) {
  String keyClean = removeDiacritics(key.toLowerCase());

  return list
      .where((e) => removeDiacritics(e.noiDung.toLowerCase()).contains(keyClean))
      .map((e) => e.thanhTien.toDouble())   // chuyển int sang double
      .fold(0, (a, b) => a + b);
}

  // ===== LIST OF BILL ITEMS =====
  final items = [
    {"title": "Tiền thuê phòng", "unit": "1 tháng", "price": getPrice("Tiền thuê phòng")},
    {"title": "Điện", "unit":"kWh", "price": getPrice("Điện")},
    {"title": "Nước", "unit": "Người", "price": getPrice("Nước")},
    {"title": "Internet", "unit": "Phòng", "price": getPrice("Internet")},
    {"title": "Rác", "unit": "Phòng", "price": getPrice("Rác")},
    {"title": "Gửi xe", "unit": "Phòng", "price": getPrice("Gửi xe")},
  ];

  return items.map((e) {
    return _billItem(
      icon: Icons.receipt_long,
      title: e["title"].toString(),
      unit: e["unit"].toString(),
      price: (e["price"] as num).toDouble(),
    );
  }).toList();
}

  // ===================== BILL ITEM CARD ======================
  Widget _billItem({
    required IconData icon,
    required String title,
    required String unit,
    required double price,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text(unit, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(formatCurrency(price), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // ===================== ROW TEXT ======================
  Widget _buildRow(String left, String right, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(right, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}
