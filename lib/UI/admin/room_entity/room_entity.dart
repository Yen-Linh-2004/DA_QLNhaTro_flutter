import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/room_entity/deposit_room.dart';
import 'package:flutter_application/UI/admin/room_entity/detail_room_entity.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Ảnh phòng
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              room.imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Nội dung thông tin
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      room.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "${room.price.toStringAsFixed(0)} VNĐ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      room.description!,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Text('/tháng', style: TextStyle(color: Colors.grey[700])),
                  ],
                ),
                SizedBox(height: 6),
                Text("Diện tích: ${room.area} m²"),

                // SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RoomDetailPage()),
                        );
                      },
                      child: Text("chi tiết", style: TextStyle(color: Colors.green),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DepositPage()),
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
