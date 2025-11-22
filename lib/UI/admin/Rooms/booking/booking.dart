import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/Rooms/booking/create_booking.dart';
import 'package:flutter_application/UI/admin/Rooms/booking/create_contact_booking.dart';
import 'package:flutter_application/UI/admin/Rooms/booking/detail_booking.dart';
import 'package:flutter_application/UI/admin/Rooms/booking/refund.dart';
import 'package:flutter_application/UI/shared/SummaryCard.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';

class BookingManagementPage extends StatefulWidget {
  const BookingManagementPage({super.key});

  @override
  State<BookingManagementPage> createState() => _BookingManagementPageState();
}

class _BookingManagementPageState extends State<BookingManagementPage> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> bookings = [
    {
      "name": "Hoàng Văn E",
      "phone": "0913456789",
      "room": "P103",
      "date": "01/04/2024",
      "duration": "12 tháng",
      "deposit": "7.000.000đ",
      "status": "Chờ xác nhận",
      "statusColor": Colors.amber.shade100,
      "statusTextColor": Colors.orange.shade700,
    },
    {
      "name": "Nguyễn Thị F",
      "phone": "0987654321",
      "room": "P205",
      "date": "25/03/2024",
      "duration": "6 tháng",
      "deposit": "9.000.000đ",
      "status": "Đã xác nhận",
      "statusColor": Colors.green.shade100,
      "statusTextColor": Colors.green.shade800,
    },
    {
      "name": "Trần Văn G",
      "phone": "0901122334",
      "room": "P302",
      "date": "20/03/2024",
      "duration": "3 tháng",
      "deposit": "8.000.000đ",
      "status": "Hoàn thành",
      "statusColor": Colors.blue.shade100,
      "statusTextColor": Colors.blue.shade800,
    },
    {
      "name": "Lê Thị H",
      "phone": "0934567890",
      "room": "P104",
      "date": "15/04/2024",
      "duration": "12 tháng",
      "deposit": "7.200.000đ",
      "status": "Đã hủy",
      "statusColor": Colors.red.shade100,
      "statusTextColor": Colors.red.shade800,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCards(),
            SizedBox(height: 16),

            // // --- Thanh tìm kiếm & lọc ---
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextField(
            //         controller: searchController,
            //         decoration: InputDecoration(
            //           hintText: "Tìm kiếm theo tên khách hàng...",
            //           prefixIcon:  Icon(Icons.search),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           contentPadding:  EdgeInsets.symmetric(vertical: 0),
            //         ),
            //       ),
            //     ),
            //      SizedBox(width: 10),
            //     IconButton(
            //       icon:  Icon(Icons.filter_list, color: Colors.grey),
            //       onPressed: () {},
            //     ),
            //   ],
            // ),

            //  SizedBox(height: 20),

            // --- Danh sách đặt phòng ---
            ListView.builder(
              shrinkWrap: true,
              physics:  NeverScrollableScrollPhysics(),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Card(
                  margin:  EdgeInsets.only(bottom: 12),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tên + phòng
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              booking["name"],
                              style:  TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              booking["room"],
                              style:  TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                         SizedBox(height: 4),
                        Text(
                          booking["phone"],
                          style:  TextStyle(color: Colors.grey),
                        ),
                         SizedBox(height: 8),

                        _buildInfoRow("Ngày nhận phòng:", booking["date"]),
                        _buildInfoRow("Thời hạn:", booking["duration"]),
                        _buildInfoRow(
                          "Tiền cọc:",
                          booking["deposit"],
                          valueColor: Colors.green.shade700,
                        ),

                         SizedBox(height: 8),
                        // Trạng thái
                        Container(
                          padding:  EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: booking["statusColor"],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            booking["status"],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: booking["statusTextColor"],
                            ),
                          ),
                        ),

                         SizedBox(height: 10),
                        // Hành động
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Xem chi tiết (luôn hiển thị)
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingDetailPage(),
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
                            if (booking["status"] == "Chờ xác nhận") ...[
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
                                           RefundFullPage(),
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
                            if (booking["status"] == "Đã xác nhận") ...[
                              IconButton(
                                onPressed: () {
                                   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                           CreateContractPage(),
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
                                      builder: (context) =>
                                           RefundFullPage(),
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
                            if (booking["status"] == "Đã hủy" ||
                                booking["status"] == "Hoàn thành")
                              ...[],
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateBookingPage()),
          );
        },
        backgroundColor: Color(0xFF4A90E2),
        icon: Icon(Icons.add, color: Colors.white,),
        label: Text("Tạo đặt phòng", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
    );
  }

  // --- Widget phụ trợ ---
  Widget _buildStatCard(
    String label,
    String count,
    Color bgColor,
    Color textColor,
  ) {
    return Expanded(
      child: Container(
        margin:  EdgeInsets.all(4),
        padding:  EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: textColor,
              ),
            ),
             SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(label, style:  TextStyle(color: Colors.black54)),
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
      physics:  NeverScrollableScrollPhysics(),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
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
