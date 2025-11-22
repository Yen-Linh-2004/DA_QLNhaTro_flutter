import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/Rooms/type_room/add_typeroom.dart';
import 'package:flutter_application/UI/admin/Rooms/type_room/update_typeroom.dart';
import 'package:flutter_application/UI/shared/SummaryCard.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';

class TypeRoomPage extends StatelessWidget {
  const TypeRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCards(), 
             SizedBox(height: 20),

             Text(
              "Danh sách loại phòng",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

             SizedBox(height: 8),

            ..._roomList.map((room) => RoomCard(room: room)).toList(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  AddTypeRoomPage()),
          );
        },
        backgroundColor:  Color(0xFF4A90E2),
        child:  Icon(Icons.add),
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
      physics:  NeverScrollableScrollPhysics(),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,

        /// FIX: tăng chiều cao để chữ không bị ép
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
      margin:  EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset:  Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Padding(
          padding:  EdgeInsets.all(16),
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
                   SizedBox(width: 10),
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
                  Transform.translate(
                    offset: Offset(17, 0),
                    child: IconButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  UpdateTypeRoomPage()),
                        );
                      }, icon: Icon(Icons.edit_outlined, size: 22, color: Colors.blue)
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                        showConfirmDialog(
                        context: context,
                        title: "Xác nhận xóa loại phòng",
                        message: "Bạn có chắc chắn muốn xóa loại phòng này không?",
                        confirmColor: Colors.redAccent,
                        icon: Icons.delete_forever,
                        maxHeight: 140,
                        onConfirm: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                            content: Text(
                              "Đã xóa loại phòng thành công!",
                            ),
                            backgroundColor: Colors.orange,
                          ));
                        },
                      );
                    }, icon: Icon(Icons.delete, size: 22, color: Colors.redAccent)
                  ),
                ],
              ),

              SizedBox(height: 8),
              Text(room.desc, style:  TextStyle(fontSize: 13)),
              SizedBox(height: 8),

              Row(
                children: [
                   Icon(Icons.price_change, size: 18),
                   SizedBox(width: 4),
                  Text(room.price),
                   Spacer(),
                  Text(room.area, style:  TextStyle(color: Colors.black54)),
                ],
              ),

               SizedBox(height: 8),

              Wrap(
                spacing: 6,
                children: room.features
                    .map(
                      (e) => Chip(
                        label: Text(e),
                        backgroundColor: Colors.grey.shade100,
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    )
                    .toList(),
              ),

               Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statusItem(Icons.check_circle, "Đã thuê", room.rented, Colors.green),
                  _statusItem(Icons.meeting_room, "Trống", room.available, Colors.orange),
                  _statusItem(Icons.build, "Bảo trì", room.maintenance, Colors.redAccent),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusItem(IconData icon, String label, int count, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
         SizedBox(width: 4),
        Text("$label: $count"),
      ],
    );
  }
}

class RoomInfo {
  final String name;
  final String desc;
  final String price;
  final String area;
  final List<String> features;
  final int rented;
  final int available;
  final int maintenance;
  final Color color;

  RoomInfo({
    required this.name,
    required this.desc,
    required this.price,
    required this.area,
    required this.features,
    required this.rented,
    required this.available,
    required this.maintenance,
    required this.color,
  });
}

// ------------------------------------------------
// Dummy Data
// ------------------------------------------------

final List<RoomInfo> _roomList = [
  RoomInfo(
    name: "Phòng thường",
    desc: "Phòng tiêu chuẩn cho sinh viên hoặc người đi làm, có gác lửng.",
    price: "2.600.000đ/tháng",
    area: "25m²",
    features: ["Gác", "Kệ chén bát"],
    rented: 30,
    available: 0,
    maintenance: 0,
    color: Colors.blue,
  ),
  RoomInfo(
    name: "Phòng kiot",
    desc: "Phù hợp cho hộ gia đình nhỏ hoặc kinh doanh tại nhà.",
    price: "2.700.000đ/tháng",
    area: "25m²",
    features: ["Gác", "Kệ chén bát"],
    rented: 2,
    available: 0,
    maintenance: 0,
    color: Colors.teal,
  ),
  RoomInfo(
    name: "Phòng ban công",
    desc: "Có ban công rộng rãi, đón ánh sáng tự nhiên.",
    price: "2.600.000đ/tháng",
    area: "25m²",
    features: ["Gác", "Kệ chén bát"],
    rented: 5,
    available: 1,
    maintenance: 0,
    color: Colors.orange,
  ),
  RoomInfo(
    name: "Phòng gốc",
    desc: "Phòng ở góc tòa nhà, tạo cảm giác riêng tư, yên tĩnh quanh năm.",
    price: "2.600.000đ/tháng",
    area: "25m²",
    features: ["Gác", "Kệ chén bát"],
    rented: 8,
    available: 0,
    maintenance: 0,
    color: Colors.green,
  ),
  RoomInfo(
    name: "Phòng trệt",
    desc: "Tầng trệt, thuận tiện di chuyển, phù hợp cho gia đình có trẻ nhỏ.",
    price: "2.600.000đ/tháng",
    area: "25m²",
    features: ["Gác", "Kệ chén bát"],
    rented: 6,
    available: 0,
    maintenance: 0,
    color: Colors.purple,
  ),
  RoomInfo(
    name: "Phòng tầng thượng",
    desc: "Tầng cao, thoáng mát, yên tĩnh, thích hợp nghỉ ngơi buổi tối.",
    price: "2.500.000đ/tháng",
    area: "25m²",
    features: ["Gác", "Kệ chén bát"],
    rented: 3,
    available: 0,
    maintenance: 0,
    color: Colors.redAccent,
  ),
];
