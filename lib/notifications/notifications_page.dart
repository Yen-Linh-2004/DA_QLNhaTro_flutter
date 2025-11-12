import 'package:flutter/material.dart';
import 'package:flutter_application/notifications/add_notifications.dart';
import 'package:flutter_application/notifications/update_notifications.dart';

class NotificationManagementPage extends StatefulWidget {
 const NotificationManagementPage({super.key});

  @override
  State<NotificationManagementPage> createState() => _NotificationManagementPageState();
}

class _NotificationManagementPageState extends State<NotificationManagementPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter = 'all';

  final List<Map<String, String>> notifications = [
    {
      'title': 'Thông báo bảo trì hệ thống điện',
      'content': 'Khu trọ sẽ tạm ngừng cung cấp điện từ 8h-12h ngày 25/01 để bảo trì hệ thống. Mong mọi người thông cảm.',
      'type': 'Bảo trì',
      'created': '2024-01-20',
      'time': '09:00',
      'read': '15/20',
    },
  ];

  final List<Map<String, dynamic>> stats = [
    {
      'icon': Icons.notifications_none,
      'title': 'Tổng thông báo',
      'value': '4',
      'color': Colors.blue,
    },
    {
      'icon': Icons.send,
      'title': 'Đã gửi',
      'value': '2',
      'color': Colors.green,
    },
    {
      'icon': Icons.calendar_today,
      'title': 'Đã lên lịch',
      'value': '1',
      'color': Colors.orange,
    },
    {
      'icon': Icons.edit_note,
      'title': 'Bản nháp',
      'value': '1',
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotificationsPage()),
          );
        },
        icon: Icon(Icons.add, color: Colors.white),
        label: Text("Tạo thông báo", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tạo và quản lý thông báo gửi đến khách thuê",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            SizedBox(height: 20),
            _buildTabFilters(),
            SizedBox(height: 20),
            _buildSummaryCards(),
            SizedBox(height: 20),
            _buildSearchAndFilter(),
            SizedBox(height: 20),
            _buildNotificationList(),
          ],
        ),
      ),
    );
  }

  // Tabs lọc
  Widget _buildTabFilters() {
    final List<String> tabs = ['Tất cả', 'Đã gửi (2)', 'Đang lên lịch (1)', 'Nháp (1)'];

    List<Widget> tabWidgets = [];
    for (var t in tabs) {
      bool isActive = t.startsWith('Tất cả');
      tabWidgets.add(
        Container(
          margin: EdgeInsets.only(right: 8),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          decoration: BoxDecoration(
            color: isActive ? Colors.deepPurple.shade50 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive ? Colors.deepPurple : Colors.grey.shade400,
            ),
          ),
          child: Text(
            t,
            style: TextStyle(
              color: isActive ? Colors.deepPurple : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: tabWidgets),
    );
  }

  // Thống kê tổng hợp
  Widget _buildSummaryCards() {
    List<Widget> cardList = [];

    for (var s in stats) {
      cardList.add(
        Container(
          width: MediaQuery.of(context).size.width / 2 - 22,
          height: 85,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: (s['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(s['icon'], color: s['color'], size: 32),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s['title'], style: TextStyle(fontSize: 16, color: Colors.black54)),
                  Text(
                    s['value'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: s['color']),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.start,
      children: cardList,
    );
  }

  // Ô tìm kiếm + lọc loại
  Widget _buildSearchAndFilter() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Tìm theo tiêu đề, nội dung...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
              ),
            ),
            // SizedBox(width: 10),
            // Expanded(
            //   flex: 1,
            //   child: DropdownButtonFormField<String>(
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            //       contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            //     ),
            //     value: selectedFilter,
            //     items: [
            //       DropdownMenuItem(value: 'all', child: Text('Tất cả loại')),
            //       DropdownMenuItem(value: 'baotri', child: Text('Bảo trì')),
            //       DropdownMenuItem(value: 'canhbao', child: Text('Cảnh báo')),
            //     ],
            //     onChanged: (value) {
            //       setState(() {
            //         selectedFilter = value!;
            //       });
            //     },
            //   ),
            // ),
          ],
        ),
        // SizedBox(height: 10),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: TextButton.icon(
        //     onPressed: () {
        //       _searchController.clear();
        //       setState(() => selectedFilter = 'all');
        //     },
        //     icon: Icon(Icons.refresh, color: Colors.grey),
        //     label: Text("Đặt lại", style: TextStyle(color: Colors.grey)),
        //   ),
        // ),
      ],
    );
  }

  // Danh sách thông báo
  Widget _buildNotificationList() {
    List<Widget> cardWidgets = [];
    for (var n in notifications) {
      cardWidgets.add(_buildNotificationCard(n));
    }
    return Column(children: cardWidgets);
  }

  // Thẻ thông báo
  Widget _buildNotificationCard(Map<String, String> n) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  n['title']!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  n['type']!,
                  style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          SizedBox(height: 8),
          Text(
            n['content']!,
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          SizedBox(height: 10),

          // Dòng cuối: thời gian + nút
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.schedule, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text("Tạo lúc: ${n['created']} - ${n['time']}", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  SizedBox(width: 12),
                  Icon(Icons.remove_red_eye, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text("${n['read']} đã đọc", style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateNotificationsPage()),
                    );
                  }, icon: Icon(Icons.edit, color: Colors.blue)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete, color: Colors.red)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
