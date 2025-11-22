import 'package:flutter/material.dart';
import 'package:flutter_application/UI/shared/input_field.dart';

class PersonalPage extends StatefulWidget {
 const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final _nameController = TextEditingController(text: "Nguyễn Văn Anh");
  final _usenameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _roleController = TextEditingController();

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông tin cá nhân",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Color(0xFFE8E9FF),
                          child: Text(
                            "T",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A4FF6),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        // Thông tin người dùng
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Trần Thị Mai",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.edit, size: 16),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // SizedBox(height: 4),

                              Text(
                                "mai.tran@tro.com",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  _buildChip(
                                    "Nhân viên",
                                    Colors.blue.shade50,
                                    Colors.blue,
                                  ),
                                  SizedBox(width: 6),
                                  _buildChip(
                                    "Hoạt động",
                                    Colors.green.shade50,
                                    Colors.green,
                                  ),
                                ],
                              ),
                                SizedBox(height: 6),
                                _buildChip(
                                  "Tài khoản: nhanvien1",
                                  Colors.grey.shade200,
                                  Colors.grey[800]!,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ),
            // SizedBox(height: 10),
            _buildContent(_selectedIndex),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Thông tin cá nhân',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.security_outlined),
            activeIcon: Icon(Icons.security),
            label: 'Bảo mật',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attractions_outlined),
            activeIcon: Icon(Icons.attractions),
            label: 'Hoạt động',
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

  Widget _buildChip(String text, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(fontSize: 12, color: textColor)),
    );
  }

  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return _PersonInformation();
      case 1:
        return _accountSecurity();
      case 2:
        return _accountAction();
      default:
        return SizedBox();
    }
  }

  // ---------------------------
  // THÔNG TIN TÀI KHOẢN
  // ---------------------------
  Widget _PersonInformation() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField(
                  "Họ tên",
                  "Nhập họ và tên",
                  _nameController,
                  null,
                ),
                SizedBox(height: 12),
                buildTextField(
                  "Tên đăng nhập",
                  "Nhập tên đăng nhập",
                  _usenameController,
                  null,
                ),
                SizedBox(height: 12),
                buildTextField("Email", "Nhập email", _emailController, null),
                SizedBox(height: 12),
                buildTextField(
                  "Số điện thoại",
                  "Nhập số điện thoại",
                  _phoneController,
                  null,
                ),
                SizedBox(height: 12),
                buildTextField("Vai trò", "", _roleController, null),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------
  // BẢO MẬT
  // ---------------------------
  Widget _accountSecurity() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Đổi mật khẩu",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),

                    _buildTextField("Mật khẩu hiện tại *", obscure: true),
                    SizedBox(height: 12),
                    _buildTextField("Mật khẩu mới *", obscure: true),
                    SizedBox(height: 12),
                    _buildTextField("Xác nhận mật khẩu mới *", obscure: true),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Đổi mật khẩu"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bảo mật tài khoản",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildSecurityOption(
                      icon: Icons.verified_user_outlined,
                      title: "Xác thực hai yếu tố",
                      subtitle: "Bảo vệ tài khoản bằng xác thực 2FA",
                      status: "Đã bật",
                      statusColor: Colors.green,
                    ),
                    SizedBox(height: 12),

                    _buildSecurityOption(
                      icon: Icons.email_outlined,
                      title: "Thông báo đăng nhập",
                      subtitle: "Nhận email khi có đăng nhập từ thiết bị mới",
                      status: "Đã tắt",
                      statusColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 6),
        TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: statusColor),
          SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),

          Text(
            status,
            style: TextStyle(fontWeight: FontWeight.bold, color: statusColor),
          ),
        ],
      ),
    );
  }

  // ---------------------------
  // HOẠT ĐỘNG
  // ---------------------------
  final activities = [
    ActivityItem(
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
      title: "Đăng nhập thành công",
      subtitle: "Từ địa chỉ IP: 192.168.1.100",
      time: "20/01/2024 09:30",
    ),
    ActivityItem(
      icon: Icons.edit_calendar_outlined,
      iconColor: Colors.blue,
      title: "Cập nhật thông tin cá nhân",
      subtitle: "Thay đổi số điện thoại",
      time: "19/01/2024 14:20",
    ),
    ActivityItem(
      icon: Icons.key_outlined,
      iconColor: Colors.orange,
      title: "Đổi mật khẩu",
      subtitle: "Mật khẩu đã được cập nhật thành công",
      time: "18/01/2024 16:45",
    ),
    ActivityItem(
      icon: Icons.cancel_outlined,
      iconColor: Colors.red,
      title: "Đăng nhập thất bại",
      subtitle: "Sai mật khẩu từ IP: 192.168.1.55",
      time: "17/01/2024 22:15",
    ),
  ];
  Widget _accountAction() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hoạt động gần đây",
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          // Render danh sách hoạt động
          ...activities.map((e) => _buildActivityCard(e)),
        ],
      ),
    );
  }

  Widget _buildActivityCard(ActivityItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF7F8FA), // màu nền xám rất nhạt
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon trạng thái
          CircleAvatar(
            radius: 18,
            backgroundColor: item.iconColor.withOpacity(0.15),
            child: Icon(item.icon, color: item.iconColor, size: 22),
          ),

          SizedBox(width: 16),

          // Nội dung
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                SizedBox(height: 6),
                Text(
                  item.time,
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;

  ActivityItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });
}
