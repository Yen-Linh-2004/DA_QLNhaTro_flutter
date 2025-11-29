import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/Customer.dart';
import 'package:flutter_application/provider/PhongTroProvider.dart';
import 'package:provider/provider.dart';
class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoiceListPageState();
}

class _InvoiceListPageState extends State<InvoicePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PhongTroProvider>(context, listen: false)
            .fetchRoomInfoCustomer());
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<PhongTroProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xffF5F6FA),
      appBar: AppBar(
        title: Text("Hóa đơn"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildBody(invoiceProvider),
      ),
    );
  }

  Widget _buildBody(PhongTroProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(child: Text(provider.errorMessage!, style: TextStyle(color: Colors.red)));
    }

    if (provider.PhongTroList.isEmpty) {
      return const Center(child: Text("Không có hóa đơn nào"));
    }

    return ListView.builder(
      itemCount: provider.PhongTroList.length,
      itemBuilder: (context, index) {
        final hd = provider.PhongTroList[index];
        return _buildInvoiceCard(hd as HoaDonKhachThue);
      },
    );
  }

  Widget _buildInvoiceCard(HoaDonKhachThue invoice) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----- TITLE -----
          Text(
            "Hóa đơn tháng ${invoice.thang}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),
          Text("Phòng: ${invoice.maPhong}"),
          Text("Ngày lập: ${invoice.ngayLap}"),

          const SizedBox(height: 14),
          Divider(),

          // ----- Tổng tiền ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cần thanh toán",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "${invoice.conLai.toStringAsFixed(0)} đ",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ----- BUTTONS -----
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: Icon(Icons.payment),
                  label: Text("Thanh toán"),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Icon(Icons.picture_as_pdf, color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
