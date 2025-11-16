import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/paying/Createinvoicesinbulk.dart';
import 'package:flutter_application/UI/admin/paying/Input_electricity.dart';
import 'package:flutter_application/UI/admin/paying/add_incidentalcosts.dart';
import 'package:flutter_application/UI/admin/paying/collectmoney.dart';
import 'package:flutter_application/UI/admin/paying/create_bill.dart';
import 'package:flutter_application/UI/admin/paying/detail_paying.dart';
import 'package:flutter_application/UI/admin/paying/send_notifications.dart';
import 'package:flutter_application/UI/admin/shared/buildCard.dart';

class PaymentManagementPage extends StatelessWidget {
  const PaymentManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          children: [
            // ---- Summary Cards ----
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics:  NeverScrollableScrollPhysics(),
              children: [
                buildSummaryCard(Icons.check_circle, "Đã thu", "11.835.000đ", Colors.green),
                buildSummaryCard(Icons.schedule, "Chưa thu", "15.415.000đ", Colors.orange),
                buildSummaryCard(Icons.warning_amber, "Quá hạn", "1", Colors.red),
                buildSummaryCard(Icons.receipt_long, "Tổng hóa đơn", "6", Colors.blue),
              ],
            ),
             SizedBox(height: 16),

            // ---- Danh sách hóa đơn ----
            buildPaymentCard(
              "Nguyễn Văn A",
              "Dãy A • A101",
              "Tháng 10/2025",
              // "3.500.000đ",
              // "Điện: 100kWh - 350.000đ",
              // "Nước: 2 người - 120.000đ",
              "Phát sinh: 150.000đ",
              "4.410.000đ",
              "4.410.000đ",
              "Đã thanh toán",
              Colors.green,
              context
            ),
            buildPaymentCard(
              "Trần Thị B",
              "Dãy A • A102",
              "Tháng 10/2025",
              // "3.200.000đ",
              // "Điện: 80kWh - 280.000đ",
              // "Nước: 1 người - 60.000đ",
              null,
              "3.780.000đ",
              "3.200.000đ",
              "Thanh toán một phần",
              Colors.orange,
              context
            ),
            buildPaymentCard(
              "Lê Văn C",
              "Dãy B • B201",
              "Tháng 10/2025",
              // "4.000.000đ",
             // "Điện: 150kWh - 525.000đ",
              // "Nước: 3 người - 180.000đ",
             null,
             "5.045.000đ",
             "0đ",
             "Quá hạn",
              Colors.red,
              context
            ),
            buildPaymentCard(
              "Phạm Hoàng D",
              "Dãy B • B202",
              "Tháng 11/2025",
              // "3.800.000đ",
              // "Điện: 110kWh - 385.000đ",
              // "Nước: 2 người - 120.000đ",
              null,
              "4.495.000đ",
              "0đ",
              "Chờ thanh toán",
              Colors.blue,
              context
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
       mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateBillPage()),
              );
            },
            backgroundColor: Color(0xFF4A90E2),
            icon: Icon(Icons.add, color: Colors.white),
            label: Text("Tạo hóa đơn mới", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),

          SizedBox(height: 12),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateInvoicesPage()),
              );
            },
            backgroundColor: Colors.purple,
            icon: Icon(Icons.receipt_long, color: Colors.white),
            label: Text("Tạo hóa đơn hàng loạt", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          
          SizedBox(height: 12),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InputElectricityPage()),
              );
            },
            backgroundColor: Colors.green,
            icon: Icon(Icons.electric_rickshaw, color: Colors.white),
            label: Text("Nhập chỉ số điện", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ======= WIDGET: Payment Card =======
  Widget buildPaymentCard(
    String name,
    String room,
    String month,
    // String rent,
    // String electricity,
    // String water,
    String? extra,
    String total,
    String paid,
    String status,
    Color statusColor,
    BuildContext context
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding:  EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name, style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
             Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
              ],
            ),
            Text(room, style: TextStyle(color: Colors.grey.shade700)),
            SizedBox(height: 6),
            Text(month, style:  TextStyle(color: Colors.black87)),
            Divider(),
            // Text(rent),
            // Text(electricity),
            // Text(water),
            if (extra != null) Text(extra, style:  TextStyle(color: Colors.redAccent)),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tổng: $total", style:  TextStyle(fontWeight: FontWeight.w600)),
                Text("Đã trả: $paid", style: TextStyle(color: Colors.green.shade700)),
              ],
            ),
             SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Xem chi tiết
                IconButton(
                  icon: Icon(
                    Icons.visibility_outlined,
                    color: Colors.blueAccent,
                  ),
                  tooltip: "Xem chi tiết",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  PayingDetailPage()),
                    );
                  },
                ),
                if(status == "Đã thanh toán") ...[
                  // Thêm phát sinh
                  IconButton(
                    icon: Icon(Icons.add_circle_outline, color: Colors.orange),
                    tooltip: 'Thêm phát sinh',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  AddincidentalCostsPage()),
                      );
                    },
                  ),
                  // Xóa
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red),
                    tooltip: 'Xóa',
                    onPressed: () {
                     showConfirmDialog(
                        context: context,
                        title: "Xác nhận xóa hóa đơn",
                        message: "Bạn có chắc chắn muốn xóa hóa đơn này không?",
                        confirmColor: Colors.redAccent,
                        icon: Icons.delete_forever,
                        maxHeight: 140,
                        onConfirm: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                            content: Text(
                              "Đã xóa hóa đơn thành công!",
                            ),
                            backgroundColor: Colors.red,
                          ));
                        },
                      );
                    },
                  ),
                ],
                if(status != "Đã thanh toán") ...[
                  // Thêm phát sinh
                  IconButton(
                    icon: Icon(Icons.add_circle_outline, color: Colors.orange),
                    tooltip: 'Thêm phát sinh',
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  AddincidentalCostsPage()),
                    );
                    },
                  ),

                  // Xóa
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red),
                    tooltip: 'Xóa',
                    onPressed: () {
                      //   Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) =>  PayingDetailPage()),
                      // );
                    },
                  ),

                  // Thu tiền
                  IconButton(
                    icon: Icon(Icons.attach_money, color: Colors.green),
                    tooltip: 'Thu tiền',
                    onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  collectmoneyPage()),
                      );
                    },
                  ),

                  // Gửi thông báo
                  IconButton(
                    icon: Icon(Icons.notifications_none, color: Colors.blue),
                    tooltip: 'Gửi thông báo',
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  SendNotificationsPage()),
                      );
                    },
                  ),
                ],


              ],
            )
          ]
        ),
      ),
    );
  }
}
