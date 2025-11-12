import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.all(16),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildContent(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
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
        return const SizedBox();
    }
  }

  // ---------- CHUNG ----------
  Widget _generalSetting() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Thông tin chung",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildTextField("Tên hệ thống", "Nhập tên hệ thống", _nameController),
            const SizedBox(height: 12),
            _buildTextField("Email", "Nhập email", _emailController),
            const SizedBox(height: 12),
            _buildTextField("Số điện thoại", "Nhập số điện thoại", _phoneController),
            const SizedBox(height: 12),
            _buildTextField("Mô tả hệ thống", "Nhập mô tả hệ thống", _noteController),
            const SizedBox(height: 12),
            _buildTextField("Địa chỉ liên hệ trực tiếp", "Nhập địa chỉ liên hệ", _addressController),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  "Lưu thay đổi",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }

  // ---------- THÔNG BÁO ----------
  Widget _notifications() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Cài đặt thông báo",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildSwitchTile(
              title: "Thông báo email",
              subtitle: "Gửi thông báo qua email",
              value: emailNotification,
              onChanged: (val) => setState(() => emailNotification = val),
              bgColor: Colors.blue[50]
            ),
            const SizedBox(height: 8),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                const SizedBox(height: 4),
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Cài đặt bảo mật",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text("Số lần nhập sai tối đa", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
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
        padding: const EdgeInsets.all(16),
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
            const Text("Thời gian sao lưu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: () {
                // Hàm chọn thời gian ở đây
              },
              icon: const Icon(Icons.access_time_outlined, size: 20),
              label: const Text("02:00 AM"),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),

            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            const Text(
              "Thao tác hệ thống",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    // Hàm khôi phục mặc định
                  },
                  icon: const Icon(Icons.refresh_outlined, size: 20),
                  label: const Text("Khôi phục mặc định"),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),

                const SizedBox(width: 12),

                // Nút Sao lưu ngay
                OutlinedButton.icon(
                  onPressed: () {
                    // Hàm sao lưu ngay
                  },
                  icon: const Icon(Icons.download_outlined, size: 20, color: Colors.green),
                  label: const Text(
                    "Sao lưu ngay",
                    style: TextStyle(color: Colors.green),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
