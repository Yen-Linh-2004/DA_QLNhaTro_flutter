import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/UI/shared/input_field.dart';

class CreateInvoicesPage extends StatefulWidget {
  const CreateInvoicesPage({super.key});

  @override
  State<CreateInvoicesPage> createState() => _CreateInvoicesPageState();
}

class _CreateInvoicesPageState extends State<CreateInvoicesPage> {
  final List<Map<String, dynamic>> rooms = [
    {"day": "Dãy A", "phong": "A101", "khach": "Nguyễn Văn A", "tienThue": "3.500.000đ", "dien": 100, "soNguoi": 2, "checked": false},
    {"day": "Dãy A", "phong": "A102", "khach": "Trần Thị B", "tienThue": "3.200.000đ", "dien": 80, "soNguoi": 1, "checked": false},
    {"day": "Dãy B", "phong": "B201", "khach": "Lê Văn C", "tienThue": "4.000.000đ", "dien": 150, "soNguoi": 3, "checked": false},
    {"day": "Dãy B", "phong": "B202", "khach": "Phạm Hoàng D", "tienThue": "3.800.000đ", "dien": 110, "soNguoi": 2, "checked": false},
    {"day": "Dãy C", "phong": "C301", "khach": "Vũ Đình E", "tienThue": "4.500.000đ", "dien": 130, "soNguoi": 2, "checked": false},
    {"day": "Dãy C", "phong": "C302", "khach": "Trần Văn F", "tienThue": "4.100.000đ", "dien": 95, "soNguoi": 2, "checked": false},
  ];

  bool racTet = false;
  int tongSoPhongChon = 0;
  final _describeController = TextEditingController();
  final _costNumberController = TextEditingController();

  void updateCount() {
    setState(() {
      tongSoPhongChon = rooms.where((e) => e["checked"] == true).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Tạo hóa đơn hàng loạt", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(12),
        child: Column(
          children: [
            // Biểu phí áp dụng
            Container(
              width: double.maxFinite,
              padding:  EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("Biểu phí áp dụng",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                   SizedBox(height: 6),
                  Text("Tháng hóa đơn: November 2025", style: TextStyle(color: Colors.grey[700])),
                   SizedBox(height: 4),
                   Text("Giá điện: 3.500đ / kWh"),
                   Text("Giá nước: 60.000đ / Người"),
                   Text("Phí rác: 40.000đ / Phòng"),
                   Text("Phí mạng: Plan 1: 50.000đ • Plan 2: 100.000đ"),
                   Text("Phí gửi xe: 100.000đ / Xe"),
                   SizedBox(height: 4),
                  Text("Hạn thanh toán: Ngày 5 tháng sau",
                      style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),
             SizedBox(height: 12),

            // Phí phát sinh
            Container(
              padding:  EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phí phát sinh (Tùy chọn)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  CheckboxListTile(
                    value: racTet,
                    title: Text("Rác tháng Tết - 40.000đ"),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (v) => setState(() => racTet = v ?? false),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(padding: EdgeInsetsGeometry.all(14),
                    child: Column(
                      children: [
                        buildTextField("Mô tả phí mới", "Ví dụ: Vệ sinh máy lạnh, sơn lại cửa,...", _describeController, null),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: buildTextField("Số tiền (VND)", "0", _costNumberController, null)
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade300,
                                ),
                              child:  Text("+ Thêm", style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                      ],
                    ),)
                  )
                ],
              ),
            ),
             SizedBox(height: 16),

            // Danh sách phòng
            Container(
              padding:  EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("Chọn phòng tạo hóa đơn",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                   SizedBox(height: 8),
                  ...rooms.map((room) {
                    return CheckboxListTile(
                      value: room["checked"],
                      title: Text("${room['day']} - ${room['phong']}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Khách: ${room['khach']}"),
                          Text("Tiền thuê: ${room['tienThue']} | Điện: ${room['dien']} kWh | ${room['soNguoi']} người"),
                        ],
                      ),
                      onChanged: (v) {
                        setState(() {
                          room["checked"] = v ?? false;
                          updateCount();
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
            ),

             SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding:  EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Số phòng được chọn: $tongSoPhongChon\nTổng giá trị hóa đơn: 0đ",
                style:  TextStyle(fontSize: 15),
              ),
            ),

            SizedBox(height: 20),
            // Nút hành động
            Row(
              children: [
                buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                SizedBox(width: 15),
                if (tongSoPhongChon > 0)
                  buildActionBtn(
                    Icons.receipt_long,
                    "Tạo $tongSoPhongChon hóa đơn",
                    Colors.blue,
                    () {},
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
