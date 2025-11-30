import 'package:flutter/material.dart';
import 'package:flutter_application/UI/generalPage/dashbroad.dart';
import 'package:flutter_application/UI/generalPage/login.dart';
import 'package:flutter_application/UI/admin/personal.dart';
import 'package:flutter_application/UI/users/RepairRequestDetail/RepairRequest.dart';
import 'package:flutter_application/UI/users/bill.dart';
import 'package:flutter_application/UI/users/contact.dart';
import 'package:flutter_application/UI/users/homePage.dart';
import 'package:flutter_application/UI/users/rulesandviolations.dart';
import 'package:flutter_application/UI/users/usermyroom.dart';

Color kPrimaryColor = Color(0xFF00ADB5);
Color kAccentColor = Color(0xFFFF5722);
Color kBackgroundColor = Color(0xFFEEEEEE);

class TenantHomePage extends StatefulWidget {
  const TenantHomePage({super.key});
  @override
  State<TenantHomePage> createState() => _TenantHomePage();
}

class _TenantHomePage extends State<TenantHomePage> {
  String _selectedPage = 'home';
  bool isNotificationOpen = false;
  bool isUserMenuOpen = false;

  final Map<String, Widget> _pages = {
    'home': InvoicePage(),
    'room': RoomPage(),
    'contact': ContractPage(),
    'bill': BillPage(),
    'maintenance': RepairRequestPage(),
    'rule': RulesAndViolationsPage()
  };

  final List<Map<String, String>> notifications = [
    {"title": "Phòng 101 cần thanh toán tiền điện", "time": "2 giờ trước"},
    {"title": "Yêu cầu bảo trì từ phòng 205", "time": "5 giờ trước"},
    {"title": "Hợp đồng phòng 303 sắp hết hạn", "time": "1 ngày trước"},
  ];

  void _selectPage(String pageKey) {
    setState(() {
      _selectedPage = pageKey;
    });
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  String _getPageTitle() {
    switch (_selectedPage) {
      case 'home':
        return "Trang chủ";
      case 'room':
        return "Phòng Của Tôi";
      case 'contact':
        return "Thông Tin Hợp Đồng";
      case 'maintenance':
        return "Yêu Cầu Sửa Chữa";
      case 'bill':
        return "Hóa đơn";
      case 'rule':
        return "Nội quy và vi phạm";
      default:
        return "Trang chủ";
    }
  }

  late OverlayEntry _notificationOverlay;
  late OverlayEntry _userMenuOverlay;

  _toggleNotification() {
    if (isNotificationOpen) {
      _notificationOverlay.remove();
    } else {
      _notificationOverlay = _createNotificationOverlay();
      Overlay.of(context).insert(_notificationOverlay);
    }

    setState(() {
      isNotificationOpen = !isNotificationOpen;
    });
  }

  OverlayEntry _createNotificationOverlay() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: kToolbarHeight + 10,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 280,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12,
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(.15),
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thông báo",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),

                // --- Danh sách thông báo có thể bấm ---
                ...notifications.map((item) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"]!,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4),
                          Text(
                            item["time"]!,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _toggleUserMenu() {
    if (isUserMenuOpen) {
      _userMenuOverlay.remove();
    } else {
      _userMenuOverlay = _createUserMenuOverlay();
      Overlay.of(context).insert(_userMenuOverlay);
    }

    setState(() {
      isUserMenuOpen = !isUserMenuOpen;
    });
  }

  OverlayEntry _createUserMenuOverlay() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: kToolbarHeight + 10,
        right: 10,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12,
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(.15),
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildMenuItem(null, "Trần Thị Mai\n @Nhanvien1", () {}),
                Divider(height: 1),
                _buildMenuItem(Icons.person, "Thông tin cá nhân", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PersonalPage()),
                  );
                  _toggleUserMenu();
                }),
                Divider(height: 1),
                _buildMenuItem(Icons.logout, "Đăng xuất", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                  _toggleUserMenu();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeMobilePage()),
                    (route) => false,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          _getPageTitle(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white),
            onPressed: _toggleNotification,
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Colors.white),
            onPressed: _toggleUserMenu,
          )
        ],
      ),

      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_selectedPage],
      ),

      drawer: _buildDrawer(),
    );
  }

  // Drawer Menu Builder
  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Yến Linh",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              accountEmail:
                  Text("yenlinh@gmail.com", style: TextStyle(color: Colors.white70)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset("lib/assets/images/log.png",
                      width: 80, height: 80, fit: BoxFit.cover),
                ),
              ),
              decoration: BoxDecoration(color: kPrimaryColor),
            ),
            _buildDrawerItem(Icons.home_outlined, "Trang chủ", 'home'),
            _buildDrawerItem(Icons.meeting_room_outlined, "Phòng của tôi", 'room'),
            _buildDrawerItem(Icons.receipt_long, "Hóa đơn", 'bill'),
            _buildDrawerItem(Icons.description_outlined, "Hợp đồng", 'contact'),
            _buildDrawerItem(Icons.article, "Nội quy và vi phạm", 'rule'),
            _buildDrawerItem(Icons.build_circle_outlined, "Yêu cầu bảo trì", 'maintenance'),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: kAccentColor),
              title: Text("Đăng xuất",
                  style: TextStyle(color: kAccentColor, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeMobilePage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Drawer item
  Widget _buildDrawerItem(IconData icon, String title, String pageKey) {
    final bool isSelected = _selectedPage == pageKey;

    return ListTile(
      leading: Icon(icon, color: isSelected ? Color(0xFF007BFF) : Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Color(0xFF007BFF) : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Color(0xFFE8F1FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: () => _selectPage(pageKey),
    );
  }

  // Build menu item for user dropdown
  Widget _buildMenuItem(IconData? icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 20),
            SizedBox(width: 10),
            Text(text, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
