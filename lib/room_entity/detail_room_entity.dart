import 'package:flutter/material.dart';
import 'package:flutter_application/room_entity/deposit_room.dart';
import 'package:flutter_application/shared/buildCard.dart';

class RoomDetailPage extends StatelessWidget {
  // Dữ liệu mock (tạm thời)
  final String roomName = "Phòng B205";
  final String monthlyRent = "2.600.000 VNĐ/tháng";
  final String deposit = "2.600.000 VNĐ";

  // Tiện nghi
  final List<String> amenities = [
    "Điều hòa",
    "Tủ lạnh",
    "Giường",
    "Tủ quần áo",
    "Bàn học",
    "Wifi",
  ];

  // Dịch vụ & Chi phí
  final Map<String, String> services = {
    "Điện": "3.500 đ/kWh",
    "Nước": "60.000 đ/người",
    "Rác": "40.000 đ/phòng",
    "Gửi xe": "100.000 đ/xe",
    "Internet": "50.000 đ/phòng",
  };

  // Tiện ích xung quanh
  final Map<String, String> nearby = {
    "Siêu thị CO.opmart": "200m",
    "Trường ĐH Kinh tế": "500m",
    "Bệnh viện": "300m",
    "Ngân hàng Vietcombank": "150m",
  };

  // Thông tin cơ bản
  final Map<String, String> basicInfo = {
    "Số phòng": "B205",
    "Dãy": "2",
    "Loại phòng": "Phòng ban công",
    "Diện tích": "25m²",
    "Trạng thái": "Trống",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 100),
        children: [
          // --- THÔNG TIN CƠ BẢN VÀ TRẠNG THÁI ---
          _buildInfoSection(
            title: "Thông Tin Cơ Bản",
            icon: Icons.info_outline,
            children:
                basicInfo.entries.map((entry) {return _buildBasicInfoRow(entry.key, entry.value);
                }).toList()..add(
                  _buildAvailableDate("Vào ngay hôm nay", isAvailable: true),
                ),
          ),

          // --- CHI PHÍ ---
          _buildInfoSection(
            title: "Chi Phí & Đặt Cọc",
            icon: Icons.monetization_on_outlined,
            children: [
              _buildPriceRow("Giá thuê", monthlyRent, color: Colors.blue),
              _buildPriceRow("Tiền cọc", deposit, color: Colors.orangeAccent),
            ],
          ),

          // --- MÔ TẢ ---
          _buildInfoSection(
            title: "Mô Tả Phòng",
            icon: Icons.description_outlined,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Phòng studio rộng rãi, đầy đủ nội thất, view đẹp. Thích hợp cho sinh viên hoặc người đi làm.",
                  style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                ),
              ),
            ],
          ),

          // --- TIỆN NGHI ---
          _buildInfoSection(
            title: "Tiện Nghi Đã Có",
            icon: Icons.check_circle_outline,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: amenities
                      .map((amenity) => _buildAmenityChip(amenity))
                      .toList(),
                ),
              ),
            ],
          ),

          // --- DỊCH VỤ & CHI PHÍ KHÁC ---
          _buildInfoSection(
            title: "Dịch Vụ & Chi Phí Khác",
            icon: Icons.payments_outlined,
            children: services.entries.map((entry) {
              return _buildServiceRow(entry.key, entry.value);
            }).toList(),
          ),

          // --- TIỆN ÍCH XUNG QUANH ---
          _buildInfoSection(
            title: "Tiện Ích Xung Quanh",
            icon: Icons.location_on_outlined,
            children: nearby.entries.map((entry) {
              return _buildNearbyFacility(entry.key, entry.value);
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                buildActionBtn(Icons.close, "Đóng", Colors.red, () => Navigator.pop(context)),
                SizedBox(width: 10),
                buildActionBtn(Icons.bookmark_added, "Đặt cọc ngay", Colors.blue, (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DepositPage()),
                  );
                }),
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 24),
                SizedBox(width: 8),
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(height: 15, color: Colors.grey),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoRow(String key, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key + ":",
            style: TextStyle(fontSize: 17, color: Colors.grey[700]),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableDate(String date, {required bool isAvailable}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isAvailable ? Colors.blue[100] : Colors.red[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Có thể vào:",
              style: TextStyle(
                fontSize: 18,
                color: isAvailable ? Colors.blue[800] : Colors.red[800],
              ),
            ),
            Text(
              date,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isAvailable ? Colors.blue[800] : Colors.red[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String key, String value, {required Color color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(key + ":", style: TextStyle(fontSize: 17, color: Colors.grey[700])),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityChip(String amenity) {
    return Chip(
      label: Text(amenity, style: TextStyle(color: Colors.white, fontSize: 17)),
      backgroundColor: Colors.blueGrey,
    );
  }

  Widget _buildServiceRow(String service, String price) {
    return ListTile(
      dense: true,
      leading: Icon(Icons.check, color: Colors.blue, size: 16),
      title: Text(service, style: TextStyle(fontSize: 17)),
      trailing: Text(
        price,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(221, 51, 50, 50),
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _buildNearbyFacility(String name, String distance) {
    return ListTile(
      dense: true,
      leading: Icon(Icons.location_on, color: Colors.blue),
      title: Text(name),
      trailing: Text(
        distance,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
      ),
    );
  }
}
