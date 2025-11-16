import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/maintenance/create_maintenance.dart';
import 'package:flutter_application/UI/admin/maintenance/detail_maintenance.dart';
import 'package:flutter_application/UI/admin/maintenance/staff_assignment.dart';
import 'package:flutter_application/UI/admin/maintenance/update_status.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: _MaintenanceBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  AddMaintenancePage()),
          );
        },
        backgroundColor: Colors.purple,
        label:  Text("Tạo yêu cầu", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        icon:  Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _MaintenanceBody extends StatelessWidget {
  final List<Map<String, dynamic>> _requestItems = [
    {
      "title": "Điều hòa không lạnh",
      "date": "15/3/2024",
      "guest": "Nguyễn Văn An",
      "room": "A101",
      "category": "Thiết bị",
      "level": "Cao",
      "status": "Đang xử lý",
      "assign": "Tuấn",
    },
    {
      "title": "Vòi nước bồn rửa bị rò rỉ",
      "date": "18/3/2024",
      "guest": "Trần Thị Bé",
      "room": "A202",
      "category": "Nước",
      "level": "Trung bình",
      "status": "Chờ xử lý",
      "assign": "",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:  EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thống kê
          _statusGrid(),
          SizedBox(height: 16),
          // Danh sách yêu cầu
          ..._requestItems.map((e) => _maintenanceCard(e, context)).toList(),
        ],
      ),
    );
  }
}

Widget _statusGrid() {
  final items = [
    {"name": "Chờ xử lý", "count": 3, "color": Colors.amber},
    {"name": "Đang xử lý", "count": 2, "color": Colors.purple},
    {"name": "Hoàn thành", "count": 2, "color": Colors.green},
    {"name": "Khẩn cấp", "count": 1, "color": Colors.red},
  ];

  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200, // mỗi item tối đa 200px, tự động tính số cột
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.2,
    ),
    itemCount: items.length,
    itemBuilder: (context, i) {
      var item = items[i];
      return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: (item["color"] as Color).withOpacity(.15),
              child: Icon(Icons.circle, color: item["color"] as Color, size: 16),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${item["count"]}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${item["name"]}",
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _maintenanceCard(Map<String, dynamic> item, BuildContext context) {
  return Container(
    margin:  EdgeInsets.only(bottom: 12),
    padding:  EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item["title"],
          style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          "Ngày yêu cầu: ${item["date"]}",
          style: TextStyle(color: Colors.grey.shade600),
        ),
         SizedBox(height: 8),

        // Khách
        Text("👤 ${item["guest"]} – ${item["room"]}"),

         SizedBox(height: 8),

        // Chips
        Wrap(
          spacing: 8,
          children: [
            _chip(item["category"], Colors.blue),
            _chip(item["level"], Colors.orange),
            _chip(item["status"], Colors.purple),
          ],
        ),

         SizedBox(height: 12),

        // Phân công
        Text(
          "Phân công: ${item["assign"].toString().isEmpty ? "Chưa phân công" : item["assign"]}",
          style: TextStyle(color: Colors.grey.shade800),
        ),

         SizedBox(height: 12),

        // Actions
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MaintenanceDetailPage()),
                );
              }, icon: Icon(Icons.visibility_outlined, size: 22, color: Colors.grey.shade600)
            ),
            
             SizedBox(width: 12),
            IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  UpdateStatusPage()),
                );
              }, icon: Icon(Icons.edit_outlined, size: 22, color: Colors.blue)
            ),
             SizedBox(width: 12),
            IconButton(
              onPressed: (){
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  UpdateStatusPage()),
                // );
              }, icon: Icon(Icons.delete_outline, size: 22, color: Colors.red)
            ),

             SizedBox(width: 12),
            IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  StaffAssignmentPage()),
                );
              }, icon: Icon(Icons.person_add, size: 22, color: Colors.blue)
            ),
            
             SizedBox(width: 12),
            IconButton(
              onPressed: (){
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  UpdateStatusPage()),
                // );
              }, icon: Icon(Icons.history, size: 22, color: Colors.amber)
            ),
          
          ],
        ),
      ],
    ),
  );
}

Widget _chip(String label, Color color) {
  return Container(
    padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      // ignore: deprecated_member_use
      color: color.withOpacity(.15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(label, style: TextStyle(color: color, fontSize: 12)),
  );
}
