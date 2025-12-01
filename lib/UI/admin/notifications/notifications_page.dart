import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/buildCard.dart';
import 'package:flutter_application/data/model/ThongBao.dart';
import 'package:flutter_application/provider/ThongBaoProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/UI/admin/notifications/add_notifications.dart';
import 'package:flutter_application/UI/admin/notifications/update_notifications.dart';
import 'package:intl/intl.dart';

class NotificationManagementPage extends StatefulWidget {
  const NotificationManagementPage({super.key});

  @override
  State<NotificationManagementPage> createState() =>
      _NotificationManagementPageState();
}

class _NotificationManagementPageState
    extends State<NotificationManagementPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> tabs = ['Tất cả', 'Đã gửi', 'Đang lên lịch', 'Nháp'];
  int selectedTabIndex = 0; // Lưu tab đang chọn

  @override
  void initState() {
    super.initState();
    // Gọi API sau khi widget đã mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ThongBaoProvider>(context, listen: false);
      provider.fetchThongBao();
      provider.fetchThongBaoHeThong();
    });
  }

  // Mapping tab sang giá trị backend
  String getStatusFilter(int index) {
    switch (index) {
      case 1:
        return 'sent'; 
      case 2:
        return 'scheduled'; 
      case 3:
        return 'draft';
      default:
        return ''; 
    }
  }

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 12),
              _buildTabFilters(),
              SizedBox(height: 12),
              Expanded(
                child: Consumer<ThongBaoProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    List<ThongBao> filteredNotifications;
                    if (selectedTabIndex == 0) {
                      filteredNotifications = provider.ThongBaoList;
                    } else {
                      String filter = getStatusFilter(selectedTabIndex);
                      filteredNotifications = provider.ThongBaoList
                          .where((tb) => tb.trangThai.toLowerCase() == filter)
                          .toList();
                    }

                    if (filteredNotifications.isEmpty) {
                      return Center(
                          child: Text("Chưa có thông báo nào.",
                              style: TextStyle(fontSize: 16)));
                    }

                    return ListView.separated(
                      itemCount: filteredNotifications.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final n = filteredNotifications[index];
                        return _buildNotificationCard(n);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tabs lọc
  Widget _buildTabFilters() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          bool isActive = index == selectedTabIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTabIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.deepPurple.shade50
                    : Colors.grey.shade200,
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
            ),
          );
        },
      ),
    );
  }

  // Thẻ thông báo
  Widget _buildNotificationCard(ThongBao n) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(n.tieuDe,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(n.loai,
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(n.noiDung,
              style: TextStyle(fontSize: 14, color: Colors.black87)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.schedule, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    "Thời gian: ${n.thoiGianTao != null ? dateFormat.format(n.thoiGianTao!) : '-'}",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateNotificationsPage()),
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.blue)),
                  IconButton(
                      onPressed: () {
                        showConfirmDialog(
                          context: context,
                          title: "Xác nhận xóa thông báo",
                          message: "Bạn có chắc chắn muốn xóa thông báo này không?",
                          confirmColor: Colors.red,
                          icon: Icons.flash_on_outlined,
                          maxHeight: 140,
                          onConfirm: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                              content: Text("Đã xóa thông báo thành công!"),
                              backgroundColor: Colors.red,
                            ));
                          },
                        );
                      },
                      icon: Icon(Icons.delete, color: Colors.red)),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.remove_red_eye, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                  "${n.chiTiet?.where((e) => e.trangThaiDoc == 'Đã đọc').length ?? 0} đã đọc",
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
