import 'package:flutter/material.dart';
import 'package:flutter_application/Rooms/booking/create_booking.dart';
import 'package:flutter_application/Rooms/booking/create_contact_booking.dart';
import 'package:flutter_application/Rooms/booking/detail_booking.dart';
import 'package:flutter_application/Rooms/booking/refund.dart';

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
      appBar: AppBar(
        title: const Text("Quản lý đặt phòng"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateBookingPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Tổng quan ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard(
                  "Chờ xác nhận",
                  "1",
                  Colors.amber.shade100,
                  Colors.orange,
                ),
                _buildStatCard(
                  "Đã xác nhận",
                  "1",
                  Colors.green.shade100,
                  Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard(
                  "Hoàn thành",
                  "1",
                  Colors.blue.shade100,
                  Colors.blue,
                ),
                _buildStatCard("Đã hủy", "1", Colors.red.shade100, Colors.red),
              ],
            ),
            const SizedBox(height: 16),

            // --- Thanh tìm kiếm & lọc ---
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Tìm kiếm theo tên khách hàng...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --- Danh sách đặt phòng ---
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tên + phòng
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              booking["name"],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              booking["room"],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          booking["phone"],
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),

                        _buildInfoRow("Ngày nhận phòng:", booking["date"]),
                        _buildInfoRow("Thời hạn:", booking["duration"]),
                        _buildInfoRow(
                          "Tiền cọc:",
                          booking["deposit"],
                          valueColor: Colors.green.shade700,
                        ),

                        const SizedBox(height: 8),
                        // Trạng thái
                        Container(
                          padding: const EdgeInsets.symmetric(
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

                        const SizedBox(height: 10),
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
                              icon: const Icon(
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
                                        const SnackBar(
                                          content: Text(
                                            "Đã xác nhận đặt phòng thành công!",
                                          ),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
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
                                    confirmColor: Colors.orange,
                                    icon: Icons.flash_on_outlined,
                                    maxHeight: 140,
                                    onConfirm: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Đã hủy đặt phòng thành công!",
                                          ),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
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
                                        const SnackBar(
                                          content: Text(
                                            "Đã hoàn cọc nhanh thành công!",
                                          ),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
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
                                          const RefundFullPage(),
                                    ),
                                  );
                                },
                                icon: const Icon(
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
                                          const CreateContractPage(),
                                    ),
                                  );
                                },
                                icon: const Icon(
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
                                        const SnackBar(
                                          content: Text(
                                            "Đã hoàn cọc nhanh thành công!",
                                          ),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
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
                                          const RefundFullPage(),
                                    ),
                                  );
                                },
                                icon: const Icon(
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
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 12),
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
            const SizedBox(height: 4),
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
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(label, style: const TextStyle(color: Colors.black54)),
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

  void showConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    Color confirmColor = Colors.blue,
    String confirmText = "Xác nhận",
    String cancelText = "Hủy",
    IconData? icon,
    double maxHeight = 200,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          // ✅ Giới hạn chiều cao dialog
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: maxHeight,
            ),
            child: SingleChildScrollView(
              child: Text(message),
            ),
          ),

          title: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: confirmColor),
                const SizedBox(width: 6),
              ],
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(cancelText, style: const TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: confirmColor),
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }
}
