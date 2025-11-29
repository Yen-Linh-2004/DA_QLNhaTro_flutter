import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/Customer.dart';
import 'package:flutter_application/provider/CustomerProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    final format = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ', decimalDigits: 0);
    return format.format(value);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Chi tiết hóa đơn'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Consumer<CustomerProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (provider.InvoicesList.isEmpty) {
                return const Center(child: Text('Chưa có dữ liệu hóa đơn'));
              }

              final invoice = provider.InvoicesList.first;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.settings, size: 20),
                          label: const Text('Yêu cầu sửa chữa'),
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.report, size: 20),
                          label: const Text('Báo cáo vi phạm'),
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Card chính chứa hóa đơn
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 4,
                      shadowColor: Colors.black.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Tiêu đề & hạn thanh toán
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.receipt_long, color: Colors.blue.shade700),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Hóa đơn ${invoice.thang}',
                                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Hạn thanh toán: ${invoice.ngayHetHan}',
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                                ),
                              ],
                            ),

                            const Divider(height: 36, thickness: 1),

                            // Header bảng
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                children: [
                                  Expanded(flex: 4, child: Text('HẠNG MỤC', style: headerStyle)),
                                  Expanded(flex: 1, child: Text('SL', style: headerStyle, textAlign: TextAlign.center)),
                                  Expanded(flex: 1, child: Text('ĐƠN VỊ', style: headerStyle, textAlign: TextAlign.center)),
                                  Expanded(flex: 2, child: Text('ĐƠN GIÁ', style: headerStyle, textAlign: TextAlign.right)),
                                  Expanded(flex: 2, child: Text('THÀNH TIỀN', style: headerStyle, textAlign: TextAlign.right)),
                                ],
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Danh sách hạng mục, scroll riêng biệt
                            Expanded(
                              child: invoice.chiTietHoaDon == null || invoice.chiTietHoaDon!.isEmpty
                                  ? const Center(child: Text('Không có hạng mục hóa đơn'))
                                  : ListView.separated(
                                      itemCount: invoice.chiTietHoaDon!.length,
                                      separatorBuilder: (_, __) => const Divider(height: 18, thickness: 0.7),
                                      itemBuilder: (context, index) {
                                        final item = invoice.chiTietHoaDon![index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: Row(
                                            children: [
                                              Expanded(flex: 4, child: Text(item.noiDung, style: TextStyle(fontSize: 14))),
                                              Expanded(flex: 1, child: Center(child: Text(item.soLuong.toString()))),
                                              const Expanded(flex: 1, child: Center(child: Text('-'))), // Đơn vị không có
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(formatCurrency(item.donGia),
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(color: Colors.grey.shade800))),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(formatCurrency(item.thanhTien),
                                                      textAlign: TextAlign.right,
                                                      style: const TextStyle(fontWeight: FontWeight.w600))),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ),

                            const Divider(height: 30),

                            // Tổng kết
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  buildSummaryRow('Tạm tính', formatCurrency(invoice.tongTien)),
                                  buildSummaryRow('Công nợ kỳ trước', '0 đ'),
                                  buildSummaryRow('Giảm trừ', '0 đ'),
                                  buildSummaryRow('Phí trễ hạn', '0 đ'),

                                  const Divider(height: 24),

                                  buildSummaryRow(
                                    'Cần thanh toán',
                                    formatCurrency(invoice.conLai),
                                    isBold: true,
                                    color: Colors.red.shade700,
                                  ),

                                  const SizedBox(height: 14),

                                  if (invoice.conLai == 0)
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.check_circle, color: Colors.green),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Hóa đơn đã được thanh toán',
                                            style: TextStyle(
                                              color: Colors.green.shade700,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  const SizedBox(height: 16),

                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // TODO: Xử lý tải PDF
                                    },
                                    icon: const Icon(Icons.picture_as_pdf),
                                    label: const Text('Tải PDF hóa đơn'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue.shade700,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  TextStyle get headerStyle => TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade700,
        fontSize: 13,
      );

  Widget buildSummaryRow(String label, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: 14)),
          Text(value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: color ?? Colors.black87,
                fontSize: 14,
              )),
        ],
      ),
    );
  }
}
