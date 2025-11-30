import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/Rooms/update_room.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';

class RoomDetailPage extends StatelessWidget {
  const RoomDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title:  Text("Chi tiết phòng P.103", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        elevation: 1,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 12),
            _infoCard([
              Text("Thông tin phòng", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              _infoRow("Số phòng", "P.103"),
              _infoRow("Dãy", "Dãy trọ Phượng Vĩ"),
              _infoRow("Loại phòng", "Phòng Tiêu Chuẩn"),
              _infoRow("Giá thuê", "2.600.000đ/tháng", color: Colors.green),
              _infoRow("Trạng thái", "Đã thuê", color: Colors.blue, bold: true),
              // _infoRow("Mô tả", "Phòng A101 - Phòng thường"),
            ]),
            SizedBox(height: 16),
            _amenitiesSection(amenities: ["Gác", "Kệ chén bát"]),
            SizedBox(height: 12),
            Row(
              children: [
                buildActionBtn(Icons.edit_outlined, "Chỉnh sửa", Colors.blue, (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateRoomPage(),
                    ),
                  );
                }),
                SizedBox(width: 15),
                buildActionBtn(Icons.delete, "Xóa phòng", Colors.red, (){
                 showConfirmDialog(
                    context: context,
                    title: "Xác nhận xóa phòng trọ",
                    message: "Bạn có chắc chắn muốn xóa phòng này không?",
                    confirmColor: Colors.red,
                    icon: Icons.delete_forever,
                    maxHeight: 140,
                    onConfirm: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                        content: Text("Đã xóa phòng thành công!"),
                        backgroundColor: Colors.red,
                      ));
                    },
                  );
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------
  // 🔵  CARD INFO
  // ---------------------------------------------
  Widget _infoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding:  EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset:  Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _infoRow(String label, String value, { bool bold = false, Color? color, })
  {
    return Padding(
      padding:  EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
          ),
          Expanded(
            child: Text(value, style: TextStyle(fontSize: 15, color: color ?? Colors.black, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          ),
        ],
      ),
    );
  }

  Widget _amenitiesSection({required List<String> amenities,}) 
  {
    return Container(
      width: double.infinity,
      padding:  EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 10,
            offset:  Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tiện nghi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, raints) {
              final columnWidth = (raints.maxWidth - 40) / 2;
              return Wrap(
                spacing: 40,
                runSpacing: 12,
                children: amenities.map((item) {
                  return SizedBox(
                    width: columnWidth,
                    child: Row(
                      children: [
                        Icon(Icons.check, color: Colors.green, size: 18),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(item, style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
