import 'package:flutter/material.dart';
import 'package:flutter_application/maintenance/create_maintenance.dart';
import 'package:flutter_application/maintenance/detail_maintenance.dart';
import 'package:flutter_application/maintenance/staff_assignment.dart';
import 'package:flutter_application/maintenance/update_status.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Quản lý bảo trì"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddMaintenancePage()),
                );
              },
              icon: Icon(Icons.add),
              label: Text("Tạo yêu cầu"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _MaintenanceBody(),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thống kê
          _statusGrid(),
          const SizedBox(height: 16),
          // Bộ lọc
          _filterSection(),
          const SizedBox(height: 16),
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
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 2.2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    ),
    itemCount: items.length,
    itemBuilder: (context, i) {
      var item = items[i];
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: (item["color"] as Color).withOpacity(.15),
              child: Icon(Icons.circle, color: item["color"] as Color),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["count"]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("${item["name"]}"),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Widget _filterSection() {
  return Column(
    children: [
      // Wrap(
      //   spacing: 12,
      //   runSpacing: 12,
      //   children: [
      //     _dropdown("Tất cả trạng thái"),
      //     _dropdown("Tất cả mức độ"),
      //     _dropdown("Tất cả danh mục"),
      //   ],
      // ),
      const SizedBox(height: 12),
      TextField(
        decoration: InputDecoration(
          hintText: "Tìm kiếm theo tiêu đề, phòng...",
          suffixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ],
  );
}

Widget _maintenanceCard(Map<String, dynamic> item, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          "Ngày yêu cầu: ${item["date"]}",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 8),

        // Khách
        Text("👤 ${item["guest"]} – ${item["room"]}"),

        const SizedBox(height: 8),

        // Chips
        Wrap(
          spacing: 8,
          children: [
            _chip(item["category"], Colors.blue),
            _chip(item["level"], Colors.orange),
            _chip(item["status"], Colors.purple),
          ],
        ),

        const SizedBox(height: 12),

        // Phân công
        Text(
          "Phân công: ${item["assign"].toString().isEmpty ? "Chưa phân công" : item["assign"]}",
          style: TextStyle(color: Colors.grey.shade800),
        ),

        const SizedBox(height: 12),

        // Actions
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MaintenanceDetailPage()),
                );
              }, icon: Icon(Icons.visibility_outlined, size: 22, color: Colors.grey.shade600)
            ),
            
            const SizedBox(width: 12),
            IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UpdateStatusPage()),
                );
              }, icon: Icon(Icons.edit_outlined, size: 22, color: Colors.blue)
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: (){
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const UpdateStatusPage()),
                // );
              }, icon: Icon(Icons.delete_outline, size: 22, color: Colors.red)
            ),

            const SizedBox(width: 12),
            IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StaffAssignmentPage()),
                );
              }, icon: Icon(Icons.person_add, size: 22, color: Colors.blue)
            ),
            
            const SizedBox(width: 12),
            IconButton(
              onPressed: (){
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const UpdateStatusPage()),
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
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      // ignore: deprecated_member_use
      color: color.withOpacity(.15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(label, style: TextStyle(color: color, fontSize: 12)),
  );
}
