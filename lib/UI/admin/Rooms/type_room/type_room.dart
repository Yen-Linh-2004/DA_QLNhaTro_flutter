import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/Rooms/type_room/add_typeroom.dart';
import 'package:flutter_application/UI/admin/Rooms/type_room/update_typeroom.dart';
import 'package:flutter_application/UI/shared/SummaryCard.dart';
import 'package:flutter_application/data/model/LoaiPhong.dart';
import 'package:flutter_application/provider/LoaiPhongProvider.dart';
import 'package:provider/provider.dart';

class TypeRoomPage extends StatefulWidget {
  const TypeRoomPage({super.key});

  @override
  State<TypeRoomPage> createState() => _TypeRoomPageState();
}

class _TypeRoomPageState extends State<TypeRoomPage> {
  @override
  void initState() {
    super.initState();
    // Load API khi vào màn hình
    Future.microtask(() =>
        context.read<LoaiPhongProvider>().fetchLoaiPhong());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoaiPhongProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCards(),
            const SizedBox(height: 20),

            const Text(
              "Danh sách loại phòng",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Loading
            if (provider.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              ),

            // Nếu rỗng
            if (!provider.isLoading && provider.loaiPhongList.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Không có loại phòng nào"),
                ),
              ),

            // Danh sách thật từ API
            ...provider.loaiPhongList
                .map((item) => RoomCard(room: RoomInfo.fromLoaiPhong(item)))
                .toList(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddTypeRoomPage()));
        },
        backgroundColor: const Color(0xFF4A90E2),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCards() {
    final items = [
      SummaryItem("Tổng loại phòng", "6", Icons.category, Colors.indigo),
      SummaryItem("Tổng phòng", "54", Icons.meeting_room, Colors.green),
      SummaryItem("Phòng trống", "1", Icons.hotel_class, Colors.orange),
      SummaryItem("Giá trung bình", "2.6M", Icons.attach_money, Colors.redAccent),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => SummaryCard(item: items[index]),
    );
  }
}

class RoomCard extends StatelessWidget {
  final RoomInfo room;
  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: room.color.withOpacity(0.1),
                    child: Icon(Icons.meeting_room, color: room.color),
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      room.name,
                      style: TextStyle(
                        color: room.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => UpdateTypeRoomPage()),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined,
                        size: 22, color: Colors.blue),
                  ),

                  IconButton(
                    onPressed: () {
                      _deleteConfirm(context, room.id);
                    },
                    icon: const Icon(Icons.delete,
                        size: 22, color: Colors.redAccent),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              Text(room.desc, style: const TextStyle(fontSize: 13)),
              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(Icons.price_change, size: 18),
                  const SizedBox(width: 4),
                  Text("${room.price}đ"),
                  const Spacer(),
                  Text(room.area, style: const TextStyle(color: Colors.black54)),
                ],
              ),

              const SizedBox(height: 8),

              Wrap(
                spacing: 6,
                children: room.features
                    .map((e) => Chip(
                          label: Text(e),
                          backgroundColor: Colors.grey.shade100,
                          side: BorderSide(color: Colors.grey.shade300),
                        ))
                    .toList(),
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statusItem(Icons.check_circle, "Đã thuê", Colors.green),
                  _statusItem(Icons.meeting_room, "Trống", Colors.orange),
                  _statusItem(Icons.build, "Bảo trì", Colors.redAccent),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

   Widget _statusItem(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
         SizedBox(width: 4),
        Text("$label: 0"),
      ],
    );
  }

  void _deleteConfirm(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Xác nhận xóa"),
        content: Text("Bạn muốn xóa loại phòng ID $id?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Hủy"),
          ),
          TextButton(
            onPressed: () async {
              // await context.read<LoaiPhongProvider>().deleteLoaiPhong(id);
              // Navigator.pop(context);
            },
            child: const Text("Xóa", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
class RoomInfo {
  final int id;
  final String name;
  final String desc;
  final String price;
  final String area;
  final List<String> features;
  final Color color;

  RoomInfo({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.area,
    required this.features,
    required this.color,
  });

  /// Danh sách màu mẫu
  static const List<Color> _colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.teal,
    Colors.indigo,
    Colors.brown,
    Colors.cyan,
    Colors.pink,
  ];

  /// Mapping từ LoaiPhong → RoomInfo, set màu theo tên phòng
  factory RoomInfo.fromLoaiPhong(LoaiPhong loaiPhong) {
    // Hash tên phòng → index màu
    int colorIndex = loaiPhong.tenLoaiPhong.hashCode % _colors.length;

    return RoomInfo(
      id: loaiPhong.maLoaiPhong,
      name: loaiPhong.tenLoaiPhong,
      desc: loaiPhong.moTa ?? "Không mô tả",
      price: loaiPhong.donGiaCoBan.toStringAsFixed(0),
      area: loaiPhong.dienTich != null ? "${loaiPhong.dienTich} m²" : "0 m²",
      features: loaiPhong.tienNghi ?? [],
      color: _colors[colorIndex],
    );
  }
}