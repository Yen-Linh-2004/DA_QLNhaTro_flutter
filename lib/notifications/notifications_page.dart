import 'package:flutter/material.dart';
import 'package:flutter_application/notifications/add_notifications.dart';
import 'package:flutter_application/notifications/update_notifications.dart';

class NotificationManagementPage extends StatefulWidget {
  const NotificationManagementPage({super.key});

  @override
  State<NotificationManagementPage> createState() =>
      _NotificationManagementPageState();
}

class _NotificationManagementPageState
    extends State<NotificationManagementPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter = 'all';

  final List<Map<String, String>> notifications = [
    {
      'title': 'Thông báo bảo trì hệ thống điện',
      'content':
          'Khu trọ sẽ tạm ngừng cung cấp điện từ 8h-12h ngày 25/01 để bảo trì hệ thống. Mong mọi người thông cảm.',
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
      'title': 'Đang lên lịch',
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
      // appBar: AppBar(
      //   title:  Text("Quản lý thông báo"),
      //   backgroundColor: Colors.blueAccent,
      // ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotificationsPage()),
          );
        },
        icon:  Icon(Icons.add, color: Colors.white),
        label:  Text("Tạo thông báo", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(12.0),
          child: Column(
            children: [
              // // Mô tả
              // Text(
              //   "Tạo và quản lý thông báo gửi đến khách thuê",
              //   style: TextStyle(color: Colors.grey[700], fontSize: 16),
              // ),
               SizedBox(height: 12),

              // // Tab lọc
              _buildTabFilters(),
               SizedBox(height: 12),

             // Thẻ thống kê
              // _buildSummaryCards(),
              //  SizedBox(height: 12),

              // Search bar
              // _buildSearchAndFilter(),
              //  SizedBox(height: 12),

              // Danh sách thông báo (scrollable)
              Expanded(
                child: _buildNotificationList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tabs lọc
  Widget _buildTabFilters() {
    final List<String> tabs = ['Tất cả', 'Đã gửi (2)', 'Đang lên lịch (1)', 'Nháp (1)'];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) =>  SizedBox(width: 8),
        itemBuilder: (context, index) {
          bool isActive = index == 0; // Chọn tab đầu tiên làm active
          return Container(
            padding:  EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: isActive ? Colors.deepPurple.shade50 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isActive ? Colors.deepPurple : Colors.grey.shade400,
              ),
            ),
            child: Text(
              tabs[index],
              style: TextStyle(
                color: isActive ? Colors.deepPurple : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }

  // Thống kê
  Widget _buildSummaryCards() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: stats.length,
        separatorBuilder: (_, __) =>  SizedBox(width: 12),
        itemBuilder: (context, index) {
          var s = stats[index];
          return Container(
            width: 150,
            padding:  EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (s['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(s['icon'], color: s['color'], size: 32),
                 SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(s['title'], style:  TextStyle(fontSize: 14, color: Colors.black54)),
                    Text(
                      s['value'],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: s['color']),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Search
  Widget _buildSearchAndFilter() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Tìm theo tiêu đề, nội dung...',
        prefixIcon:  Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:  EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
    );
  }

  // Danh sách thông báo
  Widget _buildNotificationList() {
    return ListView.separated(
      itemCount: notifications.length,
      separatorBuilder: (_, __) =>  SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildNotificationCard(notifications[index]);
      },
    );
  }

  // Thẻ thông báo
  Widget _buildNotificationCard(Map<String, String> n) {
    return Container(
      padding:  EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset:  Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề + loại
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(n['title']!, style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding:  EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(n['type']!, style:  TextStyle(color: Colors.orange, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
           SizedBox(height: 8),
          Text(n['content']!, style:  TextStyle(fontSize: 14, color: Colors.black87)),
           SizedBox(height: 10),
          // Thời gian + nút
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   Icon(Icons.schedule, size: 16, color: Colors.grey),
                   SizedBox(width: 4),
                  Text("Tạo lúc: ${n['created']} - ${n['time']}", style:  TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpdateNotificationsPage()),
                        );
                      },
                      icon:  Icon(Icons.edit, color: Colors.blue)),
                  IconButton(onPressed: () {}, icon:  Icon(Icons.delete, color: Colors.red)),
                ],
              ),
            ],
          ),
          // SizedBox(height: 5),
          Row(
            children: [
               Icon(Icons.remove_red_eye, size: 16, color: Colors.grey),
               SizedBox(width: 4),
              Text("${n['read']} đã đọc", style:  TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
