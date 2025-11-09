import 'package:flutter/material.dart';
import 'package:flutter_application/Rooms/add_room.dart';
import 'package:flutter_application/Rooms/detail_room.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  String selectedFilter = "Tất cả";

  final List<Map<String, dynamic>> rooms = [
    {
      "name": "Phòng A101",
      "tenant": "Trần Thị Lan",
      "status": "Đã thuê",
      "price": 3500000,
      "color": Colors.green,
    },
    {
      "name": "Phòng A102",
      "tenant": "—",
      "status": "Trống",
      "price": 3300000,
      "color": Colors.blue,
    },
    {
      "name": "Phòng B201",
      "tenant": "Lê Văn Đức",
      "status": "Đang sửa",
      "price": 3400000,
      "color": Colors.orange,
    },
    {
      "name": "Phòng B202",
      "tenant": "Phạm Minh Tuấn",
      "status": "Đã thuê",
      "price": 3600000,
      "color": Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Danh sách phòng trọ",
          style: TextStyle(
            color: Color(0xFF2E3A59),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2E3A59)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Ô tìm kiếm
            TextField(
              decoration: InputDecoration(
                hintText: "🔍 Tìm kiếm phòng...",
                hintStyle: const TextStyle(color: Colors.black45),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Bộ lọc trạng thái
            SizedBox(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip("Tất cả"),
                  _buildFilterChip("Đã thuê"),
                  _buildFilterChip("Trống"),
                  _buildFilterChip("Đang sửa"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Danh sách phòng
            Expanded(
              child: ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  if (selectedFilter != "Tất cả" &&
                      room["status"] != selectedFilter) {
                    return const SizedBox();
                  }
                  return _buildRoomCard(room);
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRoomPage()),
          );
        },
        backgroundColor: const Color(0xFF4A90E2),
        icon: const Icon(Icons.add),
        label: const Text("Thêm phòng"),
      ),
    );
  }

  // 🌟 Widget: chip lọc trạng thái
  Widget _buildFilterChip(String label) {
    final bool isSelected = selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: const Color(0xFF4A90E2),
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        elevation: isSelected ? 3 : 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onSelected: (_) {
          setState(() => selectedFilter = label);
        },
      ),
    );
  }

  // 🏠 Widget: card hiển thị thông tin phòng
  Widget _buildRoomCard(Map<String, dynamic> room) {
    Color statusColor = room["color"];
    String status = room["status"];

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.meeting_room, color: statusColor, size: 28),
        ),
        title: Text(
          room["name"],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF2E3A59),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            status == "Đã thuê"
                ? "👤 ${room['tenant']}"
                : status == "Trống"
                ? "🔓 Chưa có người thuê"
                : "🛠 Đang bảo trì",
            style: TextStyle(color: statusColor, fontWeight: FontWeight.w500),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${room['price'].toStringAsFixed(0)} đ",
              style: const TextStyle(
                color: Color(0xFF2E3A59),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RoomDetailPage()),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
              ),
              child: const Text(
                "Chi tiết",
                style: TextStyle(
                  color: Color(0xFF4A90E2),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
