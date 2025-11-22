import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/input_field.dart';

class SystemSettingPage extends StatefulWidget {
  const SystemSettingPage({super.key});

  @override
  State<SystemSettingPage> createState() => _SystemSettingPageState();
}

class _SystemSettingPageState extends State<SystemSettingPage> {
  int _selectedIndex = 0;

  final _nameController = TextEditingController();
  final _noteController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  bool emailNotification = true;
  bool appNotification = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: AnimatedSwitcher(
          duration:  Duration(milliseconds: 300),
          child: _buildContent(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Chung',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            activeIcon: Icon(Icons.notifications),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.security_outlined),
            activeIcon: Icon(Icons.security),
            label: 'Bảo mật',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Hệ thống',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return _generalSetting();
      case 1:
        return _notifications();
      case 2:
        return _security();
      case 3:
        return _settingSystem();
      default:
        return  SizedBox();
    }
  }

  // ---------- CHUNG ----------
  Widget _generalSetting() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Thông tin chung", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            buildTextField("Tên hệ thống", "Nhập tên hệ thống", _nameController, null),
            SizedBox(height: 12),
            buildTextField("Email", "Nhập email", _emailController, null),
            SizedBox(height: 12),
            buildTextField("Số điện thoại", "Nhập số điện thoại", _phoneController, null),
            SizedBox(height: 12),
            buildTextField("Mô tả hệ thống", "Nhập mô tả hệ thống", _noteController, null),
            SizedBox(height: 12),
            buildTextField("Địa chỉ liên hệ trực tiếp", "Nhập địa chỉ liên hệ", _addressController, null),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon:  Icon(Icons.save, color: Colors.white),
                label:  Text(
                  "Lưu thay đổi",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:  EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // ---------- THÔNG BÁO ----------
  Widget _notifications() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("Cài đặt thông báo",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
             SizedBox(height: 12),
            _buildSwitchTile(
              title: "Thông báo email",
              subtitle: "Gửi thông báo qua email",
              value: emailNotification,
              onChanged: (val) => setState(() => emailNotification = val),
              bgColor: Colors.blue[50]
            ),
             SizedBox(height: 8),
            _buildSwitchTile(
              title: "Thông báo ứng dụng",
              subtitle: "Gửi thông báo qua ứng dụng",
              value: appNotification,
              onChanged: (val) => setState(() => appNotification = val),
              bgColor: Colors.blue[50]
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    Color? bgColor,
    Color? color 
  }) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.grey.shade50, 
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                 SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: color ?? Colors.blueAccent,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  // ---------- BẢO MẬT ----------
  Widget _security() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("Cài đặt bảo mật",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
             SizedBox(height: 16),
             Text("Số lần nhập sai tối đa", style: TextStyle(fontWeight: FontWeight.bold)),
             SizedBox(height: 6),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration:  InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập số lần cho phép",
              ),
            ),
            SizedBox(height: 16),
            _buildSwitchTile(
              title: "Chế độ bảo trì",
              subtitle: "Tạm thời khóa hệ thống để bảo trì",
              value: emailNotification,
              onChanged: (val) => setState(() => emailNotification = val),
              bgColor: Colors.purple[50],
              color: Colors.purple
            ),
          ],
        ),
      ),
    );
  }

  // ---------- HỆ THỐNG ----------
  Widget _settingSystem() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cài đặt hệ thống", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _buildSwitchTile(
              title: "Sao lưu dữ liệu",
              subtitle: "Tự động sao lưu dữ liệu mỗi ngày",
              value: emailNotification,
              onChanged: (val) => setState(() => emailNotification = val),
              bgColor: Colors.green[50],
              color: Colors.green
            ),
            SizedBox(height: 16),
             Text("Thời gian sao lưu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
             SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: () {
                // Hàm chọn thời gian ở đây
              },
              icon:  Icon(Icons.access_time_outlined, size: 20),
              label:  Text("02:00 AM"),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),

             SizedBox(height: 16),
             Divider(height: 1),
             SizedBox(height: 16),
             Text(
              "Thao tác hệ thống",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

             SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                // Hàm khôi phục mặc định
              },
              icon:  Icon(Icons.refresh_outlined, size: 20),
              label:  Text("Khôi phục mặc định"),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),

             SizedBox(height: 12),

            // Nút Sao lưu ngay
            OutlinedButton.icon(
              onPressed: () {},
              icon:  Icon(Icons.download_outlined, size: 20, color: Colors.green),
              label:  Text(
                "Sao lưu ngay",
                style: TextStyle(color: Colors.green),
              ),
              style: OutlinedButton.styleFrom(
                side:  BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
