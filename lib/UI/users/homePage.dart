import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';

class InvoiceListPage extends StatefulWidget{
  const InvoiceListPage({super.key});

  @override
  State<InvoiceListPage> createState() => _InvoiceListPage();
}
class _InvoiceListPage extends State<InvoiceListPage> {

  List<Map<String, dynamic>> tenants = [
    {
      "icon": Icons.build,
      "title": "Yêu cầu sửa chữa",
      "text": "Báo hỏng và đặt lịch kỹ thuật"
    },
    {
      "icon": Icons.payment,
      "title": "Thanh toán",
      "text": "Xem và thanh toán hóa đơn"
    },
    {
      "icon": Icons.warning_amber,
      "title": "Báo cáo vi phạm",
      "text": "Gửi phản hồi nhanh chống"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xffF5F6FA),
      body: Padding(
        padding:  EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Các chức năng chính:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              SizedBox(height: 5),
              _buildfunctionRow(tenants),
              Container(
                padding:  EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title("Hóa đơn tháng 10/2025"),

                    _item("Tiền thuê phòng", "1 tháng", "2.600.000đ"),
                    _divider(),
                    _item("Điện", "62 kWh", "217.000đ"),
                    _divider(),
                    _item("Nước", "2 người", "120.000đ"),
                    _divider(),
                    _item("Internet (gói cơ bản)", "1 phòng", "50.000đ"),
                    _divider(),
                    _item("Rác", "1 phòng", "40.000đ"),
                    _divider(),
                    _item("Gửi xe", "1 phòng", "100.000đ"),

                     SizedBox(height: 20),
                    _title("Thông tin đọc số"),

                    _subInfo("Chỉ số điện", "1250 → 1312 kWh"),
                    SizedBox(height: 10),
                    _subInfo("Số người tính nước", "2 người"),
                    SizedBox(height: 10),
                    _subInfo("Gói Internet", "Internet 1 (50.000đ/tháng)"),

                     SizedBox(height: 20),
                    // _title("Tổng hợp"),

                     Divider(height: 24),
                    _total("Tạm tính", "3.127.000đ"),
                    _total("Công nợ kỳ trước", "0đ"),
                    _total("Giảm trừ", "0đ"),
                    _total("Phí trễ hạn", "0đ"),
                    _total("Cần thanh toán", "3.127.000đ", isBold: true),
                  ],
                ),
              ),

               SizedBox(height: 20),

              // BUTTONS
              Row(
                children: [
                buildActionBtn(Icons.payment, "Thanh toán ngay", Colors.blue, (){}),
                SizedBox(width: 15),
                buildActionBtn(Icons.picture_as_pdf, "Tải PDF", Colors.green, (){}),
                  // Expanded(
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       padding:  EdgeInsets.symmetric(vertical: 14),
                  //       backgroundColor: Colors.blue,
                  //     ),
                  //     onPressed: () {},
                  //     child:  Text(
                  //       "Thanh toán ngay",
                  //       style: TextStyle(fontSize: 16),
                  //     ),
                  //   ),
                  // ),
                  //  SizedBox(width: 12),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.grey.shade300,
                  //     foregroundColor: Colors.black,
                  //     padding:  EdgeInsets.symmetric(
                  //       vertical: 14,
                  //       horizontal: 22,
                  //     ),
                  //   ),
                  //   onPressed: () {},
                  //   child:  Text("Tải PDF"),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------
  // WIDGETS
  // ------------------------------

  Widget _title(String text) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
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
                style:  TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
             SizedBox(height: 4),
            Text(unit, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
        Text(
          price,
          style:  TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        )
      ],
    );
  }

  Widget _divider() =>  Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Divider(height: 1),
      );

  Widget _subInfo(String label, String value) {
    return Container(
      width: double.infinity,
      margin:  EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
           SizedBox(height: 2),
          Text(value),          
        ],
      ),
    );
  }

  Widget _total(String label, String amount, {bool isBold = false}) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 6),
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

  Widget _buildfunctionRow(List<Map<String, dynamic>> data) {
    return Column(
      children: data.map((t) {
        // Tự sinh màu theo icon
        Color bgColor;
        Color iconColor;

        if (t['icon'] == Icons.build) {
          bgColor =  Color(0xffEEF1FF);   // tím nhạt
          iconColor =  Color(0xff6366F1); // tím đậm
        } else if (t['icon'] == Icons.payment) {
          bgColor =  Color(0xffE8F8F1);   // xanh mint
          iconColor =  Color(0xff16A34A); // xanh đậm
        } else {
          bgColor =  Color(0xffFEECEC);   // đỏ nhạt
          iconColor =  Color(0xffDC2626); // đỏ đậm
        }

        return Container(
          margin:  EdgeInsets.only(bottom: 12),
          padding:  EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: bgColor,
                child: Icon(t['icon'], size: 22, color: iconColor),
              ),

               SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t['title'],
                      style:  TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 2),
                    Text(
                      t['text'],
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),

              // Mũi tên
              Icon(Icons.chevron_right, size: 20, color: Colors.grey.shade500),
            ],
          ),
        );
      }).toList(),
    );
  }
}
