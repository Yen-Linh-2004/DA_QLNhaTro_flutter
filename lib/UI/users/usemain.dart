import 'package:flutter/material.dart';
import 'package:flutter_application/UI/generalPage/login.dart';
import 'package:flutter_application/UI/admin/personal.dart';
import 'package:flutter_application/UI/users/RepairRequestDetail/RepairRequest.dart';
import 'package:flutter_application/UI/users/bill.dart';
import 'package:flutter_application/UI/users/contact.dart';
import 'package:flutter_application/UI/users/homePage.dart';
import 'package:flutter_application/UI/users/rulesandviolations.dart';
import 'package:flutter_application/UI/users/usermyroom.dart';

Color kPrimaryColor = const Color(0xFF00ADB5);
Color kAccentColor = const Color(0xFFFF5722);
Color kBackgroundColor = const Color(0xFFEEEEEE);

class TenantHomePage extends StatefulWidget {
  const TenantHomePage({super.key});
  @override
  State<TenantHomePage> createState() => _TenantHomePage();
}

class _TenantHomePage extends State<TenantHomePage> {
  String _selectedPage = 'home';
  bool isNotificationOpen = false;
  bool isUserMenuOpen = false;

  OverlayEntry? _notificationOverlay;
  OverlayEntry? _userMenuOverlay;

  final List<Map<String, String>> notifications = [
    {"title": "Phòng 101 cần thanh toán tiền điện", "time": "2 giờ trước"},
    {"title": "Yêu cầu bảo trì từ phòng 205", "time": "5 giờ trước"},
    {"title": "Hợp đồng phòng 303 sắp hết hạn", "time": "1 ngày trước"},
  ];

  final Map<String, Widget Function()> _pagesBuilders = {
    'home': () => InvoicePage(),
    'room': () => RoomPage(),
    'contact': () => ContractPage(),
    'bill': () => BillPage(),
    'maintenance': () => RepairRequestPage(),
    'rule': () => RulesAndViolationsPage(),
  };

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
        return "Phòng của tôi";
      case 'contact':
        return "Thông tin hợp đồng";
      case 'maintenance':
        return "Yêu cầu sửa chữa";
      case 'bill':
        return "Hóa đơn";
      case 'rule':
        return "Nội quy và vi phạm";
      default:
        return "Trang chủ";
    }
  }

  void _toggleNotification() {
    if (isNotificationOpen) {
      _removeNotificationOverlay();
    } else {
      _showNotificationOverlay();
    }
    setState(() => isNotificationOpen = !isNotificationOpen);
  }

  void _showNotificationOverlay() {
    _notificationOverlay = _createNotificationOverlay();
    Overlay.of(context)?.insert(_notificationOverlay!);
  }

  void _removeNotificationOverlay() {
    try {
      _notificationOverlay?.remove();
    } catch (_) {}
    _notificationOverlay = null;
  }

  OverlayEntry _createNotificationOverlay() {
    final top = kToolbarHeight + MediaQuery.of(context).padding.top + 8;
    return OverlayEntry(
      builder: (context) => Positioned(
        top: top,
        right: 12,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 12,
                    offset: const Offset(0, 6)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Thông báo",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...notifications.map((item) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      // xử lý khi click vào thông báo
                      _removeNotificationOverlay();
                      setState(() => isNotificationOpen = false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item["title"]!,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 4),
                          Text(item["time"]!,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleUserMenu() {
    if (isUserMenuOpen) {
      _removeUserMenuOverlay();
    } else {
      _showUserMenuOverlay();
    }
    setState(() => isUserMenuOpen = !isUserMenuOpen);
  }

  void _showUserMenuOverlay() {
    _userMenuOverlay = _createUserMenuOverlay();
    Overlay.of(context)?.insert(_userMenuOverlay!);
  }

  void _removeUserMenuOverlay() {
    try {
      _userMenuOverlay?.remove();
    } catch (_) {}
    _userMenuOverlay = null;
  }

  OverlayEntry _createUserMenuOverlay() {
    final top = kToolbarHeight + MediaQuery.of(context).padding.top + 8;
    return OverlayEntry(
      builder: (context) => Positioned(
        top: top,
        right: 12,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 220,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 12,
                    offset: const Offset(0, 6)),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMenuItem(null, "Người dùng demo\n @user.demo", () {
                  _removeUserMenuOverlay();
                  setState(() => isUserMenuOpen = false);
                }),
                const Divider(height: 1),
                _buildMenuItem(Icons.person, "Thông tin cá nhân", () {
                  _removeUserMenuOverlay();
                  setState(() => isUserMenuOpen = false);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PersonalPage()));
                }),
                const Divider(height: 1),
                _buildMenuItem(Icons.logout, "Đăng xuất", () {
                  _removeUserMenuOverlay();
                  setState(() => isUserMenuOpen = false);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeNotificationOverlay();
    _removeUserMenuOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageBuilder = _pagesBuilders[_selectedPage] ?? _pagesBuilders['home']!;
    final pageWidget = pageBuilder();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          _getPageTitle(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: _toggleNotification,
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: _toggleUserMenu,
          )
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: KeyedSubtree(
          key: ValueKey(_selectedPage),
          child: pageWidget,
        ),
      ),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildDrawer() {
    // Nếu bạn có sẵn KhachThue từ provider, thay phần static này bằng dữ liệu thật.
    const demoName = "Người dùng demo";
    const demoEmail = "demo@example.com";

    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(demoName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              accountEmail: const Text(demoEmail,
                  style: TextStyle(color: Colors.white70)),
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
            _buildDrawerItem(Icons.article, "Nội quy & vi phạm", 'rule'),
            _buildDrawerItem(Icons.build_circle_outlined, "Yêu cầu bảo trì", 'maintenance'),
            const Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: kAccentColor),
              title: Text("Đăng xuất",
                  style: TextStyle(color: kAccentColor, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, String pageKey) {
    final bool isSelected = _selectedPage == pageKey;

    return ListTile(
      leading: Icon(icon, color: isSelected ? const Color(0xFF007BFF) : Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFF007BFF) : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: const Color(0xFFE8F1FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: () => _selectPage(pageKey),
    );
  }

  Widget _buildMenuItem(IconData? icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            if (icon != null) Icon(icon, size: 20),
            if (icon != null) const SizedBox(width: 10),
            Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
          ],
        ),
      ),
    );
  }
}
