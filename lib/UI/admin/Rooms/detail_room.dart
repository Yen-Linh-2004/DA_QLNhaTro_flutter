import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/Rooms/update_room.dart';
import 'package:flutter_application/UI/admin/shared/buildCard.dart';

class RoomDetailPage extends StatelessWidget {
  const RoomDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,

        // ----------------------- APPBAR -----------------------
        appBar: AppBar(
          title:  Text("Chi tiết phòng A101", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.blue,
          elevation: 1,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom:  TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(text: "Thông tin"),
              Tab(text: "Khách thuê"),
              Tab(text: "Dịch vụ"),
              Tab(text: "Thành viên"),
            ],
          ),
        ),

        // ----------------------- NỘI DUNG -----------------------
        body: TabBarView(
          children: [
            _tabDichVu(context),
            _tabThanhVien(context),
          ],
        ),

        // ----------------------- NÚT DƯỚI -----------------------
        bottomNavigationBar: _bottomButtons(context),
      ),
    );
  }

  // ============================================================================================
  // TAB 1 – THÔNG TIN PHÒNG
  // ============================================================================================
  Widget _tabThongTin(BuildContext context, bool isSmallPhone) {
    return SingleChildScrollView(
      padding:  EdgeInsets.all(16),
      child: Column(
        children: [
          _card(
            title: "Thông tin cơ bản",
            children:  [
              _infoRow("Số phòng", "A101"),
              _infoRow("Dãy", "A"),
              _infoRow("Tầng", "1"),
              _infoRow("Loại phòng", "Phòng đơn"),
              _infoRow("Diện tích", "20 m²"),
              _infoRow("Giá thuê", "3.500.000đ / tháng", color: Colors.green),
              _infoRow("Trạng thái", "Đã thuê", color: Colors.blue),
            ],
          ),
           SizedBox(height: 12),
          _card(
            title: "Tiện nghi",
            children:  [
              _amenity("Điều hòa"),
              _amenity("Tủ lạnh"),
              _amenity("Giường"),
              _amenity("Tủ quần áo"),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================================================
  // TAB 2 – KHÁCH THUÊ
  // ============================================================================================
  Widget _tabKhachThue(BuildContext context, bool isSmallPhone) {
    return SingleChildScrollView(
      padding:  EdgeInsets.all(16),
      child: Column(
        children: [
          _card(
            title: "Thông tin khách thuê",
            children:  [
              _infoRow("Họ tên", "Nguyễn Văn A"),
              _infoRow("Ngày sinh", "20/05/1995"),
              _infoRow("CMND/CCCD", "0123456789"),
              _infoRow("Điện thoại", "0901234567"),
              _infoRow("Email", "nguyenvana@email.com"),
              _infoRow("Địa chỉ", "123 Nguyễn Trãi, TP.HCM"),
            ],
          ),
           SizedBox(height: 12),
        ],
      ),
    );
  }

  // ============================================================================================
  // TAB 3 – DỊCH VỤ
  // ============================================================================================
  Widget _tabDichVu(BuildContext context) {
    return ListView(
      padding:  EdgeInsets.all(16),
      children: [
        _card(
          title: "Dịch vụ đang sử dụng",
          children: [
            _checkbox("Điện"),
            _checkbox("Nước"),
            _checkbox("Internet"),
            _checkbox("Giặt sấy"),
            _checkbox("Gửi xe"),
            _checkbox("Dọn phòng"),
          ],
        ),
      ],
    );
  }

  // ============================================================================================
  // TAB 4 – THÀNH VIÊN
  // ============================================================================================
  Widget _tabThanhVien(BuildContext context) {
    final list = [
      {
        "Họ tên": "Nguyễn Văn A",
        "SĐT": "0901234567",
        "Giới tính": "Nam",
        "Xe": "29A1-12345"
      }
    ];

    return ListView.builder(
      padding:  EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, i) {
        final tv = list[i];
        return _card(
          margin:  EdgeInsets.only(bottom: 12),
          title: tv["Họ tên"],
          children: [
            _infoRow("Điện thoại", tv["SĐT"]!),
            _infoRow("Giới tính", tv["Giới tính"]!),
            _infoRow("Xe", tv["Xe"]!),
          ],
        );
      },
    );
  }

  // ============================================================================================
  // NÚT DƯỚI CÙNG
  // ============================================================================================
  Widget _bottomButtons(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        children: [
          buildActionBtn(Icons.edit, "Chỉnh sửa", Colors.blue, () {
            Navigator.push(context,
              MaterialPageRoute(builder: (_) =>  UpdateRoomPage()));
          }),
          SizedBox(width: 10),
          buildActionBtn(Icons.picture_as_pdf, "Hợp đồng pdf", Colors.green, (){ }),
        ],
      ),
    );
  }

  Widget _checkbox(String name) {
    return Row(
      children: [
        Checkbox(value: true, onChanged: (_) {}),
        Text(name),
      ],
    );
  }

  Widget _card({
    String? title,
    required List<Widget> children,
    EdgeInsets? margin,
  }) {
    return Card(
      margin: margin,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: Padding(
        padding:  EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding:  EdgeInsets.only(bottom: 12),
                child: Text(
                  title,
                  style:  TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ...children
          ],
        ),
      ),
    );
  }
}

// =======================================================================
// WIDGET NHỎ
// =======================================================================
class _infoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

   _infoRow(this.label, this.value, {this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(label)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: color ?? Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class _amenity extends StatelessWidget {
  final String name;

   _amenity(this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
           Icon(Icons.check_circle, color: Colors.green, size: 18),
           SizedBox(width: 6),
          Text(name),
        ],
      ),
    );
  }
}
