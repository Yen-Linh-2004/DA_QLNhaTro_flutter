import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/PhieuDatCoc.dart';
import 'package:flutter_application/provider/PhieuDatCocProvider.dart';
import 'package:provider/provider.dart';

class BookingDetailPage extends StatefulWidget {
  final int bookingId;

  const BookingDetailPage({super.key, required this.bookingId});

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<PhieuDatCocProvider>(context, listen: false);
      provider.fetchPhieuDatCocById(widget.bookingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(
          "Chi tiết đặt phòng",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<PhieuDatCocProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingdetail) {
            return Center(child: CircularProgressIndicator());
          }

          final PhieuDatCoc? booking = provider.PhieuDatCocDetail;
          if (booking == null) {
            return Center(child: Text("Không tìm thấy dữ liệu đặt phòng"));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildCard(
                  title: "Thông tin khách hàng",
                  children: [
                    _buildInfoRow("Họ tên", booking.hoTenNguoiDat),
                    _buildInfoRow("Số điện thoại", booking.soDienThoaiNguoiDat),
                    _buildInfoRow("Email", booking.emailNguoiDat ?? ''),
                  ],
                ),
                SizedBox(height: 20),
                _buildCard(
                  title: "Thông tin đặt phòng",
                  children: [
                    _buildInfoRow("Phòng", booking.maPhong.toString()),
                    _buildInfoRow("Ngày nhận phòng", booking.ngayDuKienVaoO),
                    _buildInfoRow("Tiền cọc", "${booking.tienDatCoc}đ", highlight: true),
                  ],
                ),
                SizedBox(height: 20),
                _buildCard(
                  title: "Ghi chú",
                  children: [
                    TextField(
                      maxLines: 2,
                      controller: TextEditingController(text: booking.ghiChu),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text("Tạo hợn đồng", style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text("Đóng", style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(width: 130, child: Text(label, style: TextStyle(fontSize: 14, color: Colors.black54))),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: highlight ? Colors.green : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
