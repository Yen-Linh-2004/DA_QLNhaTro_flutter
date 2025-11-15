import 'package:flutter/material.dart';
import 'package:flutter_application/contact/extension_contract.dart';
import 'package:flutter_application/contact/termination_contract.dart';
import 'package:flutter_application/contact/update_contact.dart';
import 'package:flutter_application/main_page.dart';
import 'package:flutter_application/shared/buildCard.dart';

class ContractDetailPage extends StatelessWidget {
  const ContractDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết hợp đồng HD001"),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ THÔNG TIN HỢP ĐỒNG --------------------------------------------
            _sectionTitle("Thông tin hợp đồng"),
            SizedBox(height: 10),
            _infoCard([
              _infoRow("Số hợp đồng", "HD001"),
              _infoRow("Ngày ký", "10/1/2024"),
              _infoRow("Ngày bắt đầu", "15/1/2024"),
              _infoRow("Ngày kết thúc", "15/12/2024"),
              _infoRow(
                "Trạng thái",
                "Đang hiệu lực",
                color: Colors.green,
                bold: true,
              ),
              _infoRow("Số lần gia hạn", "2"),
            ]),
            SizedBox(height: 22),

            // ✅ THÔNG TIN KHÁCH THUÊ & PHÒNG ----------------------------------------
            _sectionTitle("Thông tin khách thuê & phòng"),
            SizedBox(height: 10),
            _infoCard([
              _infoRow("Khách thuê", "Nguyễn Văn A", bold: true),
              _infoRow("Phòng", "P101"),
              _infoRow(
                "Tiền thuê tháng",
                "3.500.000đ",
                color: Colors.green,
                bold: true,
              ),
              _infoRow("Tiền cọc", "7.000.000đ", color: Colors.red, bold: true),
            ]),

            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateContactPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text("Chỉnh sửa", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),

                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TerminationContractPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text("Chấm dứt", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                    showConfirmDialog(
                      context: context,
                      title: "Xác nhận xóa hợp đồng",
                      message: "Bạn có chắc chắn muốn xóa hợp đồng này không?",
                      confirmColor: Colors.redAccent,
                      icon: Icons.delete_forever,
                      maxHeight: 140,
                      onConfirm: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                          content: Text(
                            "Đã xóa hợp đồng thành công!",
                          ),
                          backgroundColor: Colors.orange,
                        ));
                      },
                    );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text("Xóa hợp đồng", style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),

                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ExtensionContractPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text("Gia hạn", style: TextStyle(color: Colors.greenAccent, fontSize: 18)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _infoCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: children),
      ),
    );
  }

  Widget _infoRow(
    String label,
    String value, {
    bool bold = false,
    Color? color,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: TextStyle(color: Colors.grey[700])),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
