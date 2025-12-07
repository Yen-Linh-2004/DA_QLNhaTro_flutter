import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/room_entity/deposit_room.dart';
import 'package:flutter_application/UI/admin/room_entity/detail_room_entity.dart';
import 'package:flutter_application/data/model/PhongTro.dart';

class RoomCard extends StatelessWidget {
  final PhongTro room;
  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Ảnh phòng (nếu API trả URL)
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              room.hinhAnh ?? "https://via.placeholder.com/300",
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tên + Giá
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(room.tenPhong, 
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("${room.giaThueHienTai} VNĐ",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    )
                  ],
                ),

                SizedBox(height: 5),
                Text("Diện tích: ${room.dienTich} m²"),

                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoomEntityDetailPage(id: room.maPhong),
                          ),
                        );
                      },
                      child: Text("Chi tiết", style: TextStyle(color: Colors.green)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DepositPage(idPhong: room.maPhong)),
                        );
                      },
                      child: Text("Đặt cọc", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Room {
  final String id;
  final String name;
  final String? description;
  final double area;
  final double price;
  final String imageUrl;
  final bool isAvailable;

  Room({
    required this.id,
    required this.name,
    required this.description,
    required this.area,
    required this.price,
    required this.imageUrl,
    required this.isAvailable,
  });
}
