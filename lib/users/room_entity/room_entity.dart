import 'package:flutter/material.dart';
import 'package:flutter_application/users/room_entity/deposit_room.dart';
import 'package:flutter_application/users/room_entity/detail_room_entity.dart';

class RoomsEntityPage extends StatelessWidget {
  final List<Room> rooms = [
    Room(
      id: "R001",
      name: "Phòng 101",
      description: "Phòng ban công - dãy 2",
      area: 20,
      price: 2500000,
      imageUrl: "lib/assets/images/room1.jpg",
      isAvailable: true,
    ),
    Room(
      id: "R002",
      name: "Phòng 102",
      description: "Phòng thường - dãy 3",
      area: 18,
      price: 2200000,
      imageUrl: "lib/assets/images/room2.jpg",
      isAvailable: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Danh sách phòng trống"),
      //   backgroundColor: const Color(0xFF007BFF),
      //   centerTitle: true,
      // ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];

          return RoomCard(room: room);
        },
      ),
    );
  }
}

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
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Nội dung thông tin
          Padding(
            padding: const EdgeInsets.all(12.0),
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
                // SizedBox(height: ),
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

                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoomDetailPage(),
                          ),
                        );
                      },
                      child: Text(
                        "chi tiết",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DepositPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Đặt cọc",
                        style: TextStyle(color: Colors.blue),
                      ),
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
