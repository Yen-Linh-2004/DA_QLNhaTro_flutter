import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/provider/PhongTroProvider.dart';
import 'package:flutter_application/data/model/PhongTro.dart';
import 'package:flutter_application/UI/admin/Rooms/add_floors.dart';
import 'package:flutter_application/UI/admin/Rooms/add_room.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  String selectedFilter = "Tất cả";
  

  @override
  void initState() {
    super.initState();
    // Lấy dữ liệu phòng từ API
    Future.microtask(() {
      Provider.of<PhongTroProvider>(context, listen: false).fetchPhongTro();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
              child: Consumer<PhongTroProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final List<PhongTro> rooms = provider.PhongTroList;

                  if (rooms.isEmpty) {
                    return const Center(child: Text("Không có phòng nào!"));
                  }

                  final filteredRooms = selectedFilter == "Tất cả"
                      ? rooms
                      : rooms.where((r) => r.trangThai == selectedFilter).toList();

                  return ListView.builder(
                    itemCount: filteredRooms.length,
                    itemBuilder: (context, index) {
                      final room = filteredRooms[index];
                      return _buildRoomCard(room, context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddRoomPage()),
              );
            },
            backgroundColor: const Color(0xFF4A90E2),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text("Thêm phòng",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddFloorPage()),
              );
            },
            backgroundColor: Colors.green,
            label: const Text("Thêm dãy phòng",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Widget: chip lọc trạng thái
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

  // Widget: card hiển thị thông tin phòng
  Widget _buildRoomCard(PhongTro room, BuildContext context) {
    Color statusColor;
    switch (room.tenLoaiPhong) {
      case "Phòng Ban Công":
        statusColor = Colors.green;
        break;
      case "Phòng Tiêu Chuẩn":
        statusColor = Colors.cyan;
        break;
      case "Phòng Góc 2 Cửa Sổ":
        statusColor = Colors.orange;
        break;
      case "Phòng Kiot Mặt Tiền":
        statusColor = Colors.lightBlueAccent;
        break;
      default:
        statusColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => RoomDetailPage(phongtro: room),
        //   ),
        // );
      },
      child: Container(
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
            room.tenPhong ?? "Phòng không tên",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF2E3A59),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
           child: Text(
              room.tenLoaiPhong ?? "",
              style: TextStyle(color: statusColor, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 60,
              maxWidth: MediaQuery.of(context).size.width * 0.25,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${room.giaThueHienTai?.toStringAsFixed(0) ?? '0'} đ",
                  style: const TextStyle(
                    color: Color(0xFF2E3A59),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
