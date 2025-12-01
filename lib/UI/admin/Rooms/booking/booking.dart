import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/Rooms/booking/create_booking.dart';
import 'package:flutter_application/UI/admin/Rooms/booking/create_contact_booking.dart';
import 'package:flutter_application/UI/admin/Rooms/booking/detail_booking.dart';
import 'package:flutter_application/UI/admin/Rooms/booking/refund.dart';
import 'package:flutter_application/UI/shared/SummaryCard.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/data/model/PhieuDatCoc.dart';
import 'package:flutter_application/provider/PhieuDatCocProvider.dart';
import 'package:provider/provider.dart';
class BookingManagementPage extends StatefulWidget {
  const BookingManagementPage({super.key});

  @override
  State<BookingManagementPage> createState() => _BookingManagementPageState();
}

class _BookingManagementPageState extends State<BookingManagementPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      Provider.of<PhieuDatCocProvider>(context, listen: false).fetchPhieuDatCoc()
    );
  }

  String trangThai(String status) {
    switch (status) {
      case "ChoXacNhan":
        return "Chờ xác nhận";
      case "DaXacNhan":
        return "Đã xác nhận";
      case "HoanTat":
        return "Hoàn tất";
      case "DaHuy":
        return "Đã hủy";
      default:
        return "Không xác định";
    }
  }

  /// --- Màu nền theo trạng thái ---
  Color statusColor (String status) {
    switch (status) {
      case "Chờ xác nhận":
        return Colors.amber.shade100;
      case "Đã xác nhận":
        return Colors.green.shade100;
      case "Hoàn thành":
        return Colors.blue.shade100;
      case "Đã hủy":
        return Colors.red.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PhieuDatCocProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final bookings = provider.PhieuDatCocList;

          if (bookings.isEmpty) {
            return Center(child: Text('Chưa có phiếu đặt cọc nào'));
          }

          

          return SingleChildScrollView(
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCards(),

                SizedBox(height: 16),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tên + phòng
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  booking.hoTenNguoiDat,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "P${booking.maPhong}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              booking.soDienThoaiNguoiDat,
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 8),

                            _buildInfoRow("Ngày nhận phòng:", booking.ngayDuKienVaoO),
                            _buildInfoRow("Tiền cọc:", "${booking.tienDatCoc}đ", valueColor: Colors.green.shade700),

                            SizedBox(height: 8),
                            Container(
                              padding:  EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor(booking.trangThai),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                trangThai(booking.trangThai),
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),

                            SizedBox(height: 10),
                            Divider(),
                            // SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Xem chi tiết (luôn hiển thị)
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingDetailPage(bookingId: booking.maPhieuDatCoc,),
                                  ),
                                );
                              },
                              icon:  Icon(
                                Icons.visibility_outlined,
                                color: Colors.purple,
                              ),
                              tooltip: "Xem chi tiết",
                            ),

                            // Nếu trạng thái là "Chờ xác nhận"
                            if (trangThai(booking.trangThai)== "Chờ xác nhận") ...[
                              IconButton(
                                onPressed: () {
                                  showConfirmDialog(
                                    context: context,
                                    title: "Xác nhận đặt phòng",
                                    message:
                                        "Bạn có chắc chắn muốn xác nhận đặt phòng cho khách thuê này không?",
                                    confirmColor: Colors.orange,
                                    icon: Icons.flash_on_outlined,
                                    maxHeight: 140,
                                    onConfirm: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                         SnackBar(
                                          content: Text(
                                            "Đã xác nhận đặt phòng thành công!",
                                          ),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon:  Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                tooltip: "Xác nhận",
                              ),
                              IconButton(
                                onPressed: () {
                                  showConfirmDialog(
                                    context: context,
                                    title: "Hủy đặt phòng",
                                    message:
                                        "Bạn có chắc chắn muốn hủy đặt phòng cho khách thuê này không không? Hành động này không thể hoàn tác.",
                                    confirmColor: Colors.red,
                                    icon: Icons.flash_on_outlined,
                                    // maxHeight: 140,
                                    onConfirm: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                         SnackBar(
                                          content: Text(
                                            "Đã hủy đặt phòng thành công!",
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon:  Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                tooltip: "Hủy",
                              ),
                              IconButton(
                                onPressed: () {
                                  showConfirmDialog(
                                    context: context,
                                    title: "Xác nhận hoàn cọc nhanh",
                                    message:
                                        "Bạn có chắc chắn muốn hoàn cọc nhanh cho đơn đặt này không?",
                                    confirmColor: Colors.orange,
                                    icon: Icons.flash_on_outlined,
                                    maxHeight: 140,
                                    onConfirm: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                         SnackBar(
                                          content: Text(
                                            "Đã hoàn cọc nhanh thành công!",
                                          ),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon:  Icon(
                                  Icons.flash_on_outlined,
                                  color: Colors.orange,
                                ),
                                tooltip: "Hoàn cọc nhanh",
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                           RefundFullPage(bookingId: booking.maPhieuDatCoc),
                                    ),
                                  );
                                },
                                icon:  Icon(
                                  Icons.attach_money,
                                  color: Colors.teal,
                                ),
                                tooltip: "Hoàn tiền đầy đủ",
                              ),
                            ],

                            // Nếu trạng thái là "Đã xác nhận"
                            if (trangThai(booking.trangThai) == "Đã xác nhận") ...[
                              IconButton(
                                onPressed: () {
                                   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateContractPage(bookingId: booking.maPhieuDatCoc),
                                    ),
                                  );
                                },
                                icon:  Icon(
                                  Icons.description_outlined,
                                  color: Colors.blue,
                                ),
                                tooltip: "Tạo hợp đồng",
                              ),
                              IconButton(
                                onPressed: () {
                                  showConfirmDialog(
                                    context: context,
                                    title: "Xác nhận hoàn cọc nhanh",
                                    message:
                                        "Bạn có chắc chắn muốn hoàn cọc nhanh cho đơn đặt này không?",
                                    confirmColor: Colors.orange,
                                    icon: Icons.flash_on_outlined,
                                    maxHeight: 140,
                                    onConfirm: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                         SnackBar(
                                          content: Text(
                                            "Đã hoàn cọc nhanh thành công!",
                                          ),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon:  Icon(
                                  Icons.flash_on_outlined,
                                  color: Colors.orange,
                                ),
                                tooltip: "Hoàn cọc nhanh",
                              ),
                              IconButton(
                                onPressed: () {
                                   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RefundFullPage(bookingId: booking.maPhieuDatCoc),
                                    ),
                                  );
                                },
                                icon:  Icon(
                                  Icons.attach_money,
                                  color: Colors.teal,
                                ),
                                tooltip: "Hoàn tiền đầy đủ",
                              ),
                            ],

                            // Nếu trạng thái là "Đã hủy" hoặc "Hoàn thành"
                            if (trangThai(booking.trangThai) == "Đã hủy" ||
                                trangThai(booking.trangThai) == "Hoàn thành")
                              ...[],
                          ],
                        )],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateBookingPage()),
          );
        },
        backgroundColor: Color(0xFF4A90E2),
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          "Tạo đặt phòng",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(label, style: TextStyle(color: Colors.black54)),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    final items = [
      SummaryItem("Chờ xác nhận", "6", Icons.pending_actions, Colors.indigo),
      SummaryItem("Đã xác nhận", "54", Icons.check_circle, Colors.green),
      SummaryItem("Hoàn thành", "1", Icons.done_all, Colors.orange),
      SummaryItem("Đã hủy", "1", Icons.cancel, Colors.redAccent),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => SummaryCard(item: items[index]),
    );
  }
   
   
}

extension on PhieuDatCoc {
  void operator [](String other) {}
}
