import 'package:flutter/material.dart';
import 'package:flutter_application/Home.dart';
import 'package:flutter_application/Rooms/Room.dart';
import 'package:flutter_application/Rooms/booking/booking.dart';
import 'package:flutter_application/Rooms/type_room/type_room.dart';
import 'package:flutter_application/contact/contactPage.dart';
import 'package:flutter_application/customers/customer.dart';
import 'package:flutter_application/finance.dart';
import 'package:flutter_application/generalPage/dashbroad.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _selectedPage = 'home';

  // Danh sách các trang
  final Map<String, Widget> _pages = const {
    'home': HomePage(),
    'typeroom': TypeRoomPage(),
    'rooms': RoomPage(),
    'booking': BookingManagementPage(),
    'contact': ContractManagementPage(),

    'finance': FinancePage(),
    'chat': Placeholder(),
    'settings': Placeholder(),

    'tenants': CustomerPage(),
    'invoices': Placeholder(),
    'reports': Placeholder(),
    'support': Placeholder(),
  };

  // Danh sách trang trong bottom nav
  final List<String> _bottomNavPages = [
    'home',
    'rooms',
    'finance',
    'chat',
    'settings',
  ];

  void _selectPage(String pageKey) {
    setState(() {
      _selectedPage = pageKey;
    });
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  void _selectBottomItem(String pageKey) {
    setState(() {
      _selectedPage = pageKey;
    });
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _bottomNavPages.indexOf(_selectedPage);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF007BFF),
        title: Text(_getPageTitle(), style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_selectedPage],
      ),
      drawer: _buildAppDrawer(context),
  );
}

  /// Drawer
  Drawer _buildAppDrawer(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF007BFF), Color(0xFF5AA9FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
            ),
            accountName: Text("Nguyễn Văn Minh", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            accountEmail: Text("minh.nguyen@example.com"),
          ),

          _buildDrawerSectionTitle("Trang chính"),
          _buildDrawerItem(Icons.home_outlined, "Trang chủ", 'home'),
          _buildDrawerItem(Icons.local_offer_outlined, "Loại phòng", 'typeroom',),
          _buildDrawerItem(Icons.meeting_room_outlined, "Phòng trọ", 'rooms'),
          _buildDrawerItem(Icons.attach_money_outlined, "Đặt phòng", 'booking'),
          _buildDrawerItem(Icons.contact_emergency, "Hợp đồng", 'contact'),
          Divider(),
          _buildDrawerSectionTitle("Quản lý"),
          _buildDrawerItem(Icons.people_outline, "Khách thuê", 'tenants'),
          _buildDrawerItem(Icons.receipt_long_outlined, "Hóa đơn", 'invoices'),
          _buildDrawerItem(Icons.bar_chart_outlined, "Báo cáo", 'reports'),

          Divider(),
          _buildDrawerSectionTitle("Khác"),
          _buildDrawerItem(Icons.chat_bubble_outline, "Chat", 'chat'),
          _buildDrawerItem(Icons.settings_outlined, "Cài đặt", 'settings'),
          _buildDrawerItem(Icons.support_agent_outlined, "Hỗ trợ", 'support'),

          Divider(height: 24),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.redAccent),
            title: Text("Đăng xuất", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeMobilePage()),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Tiêu đề nhóm trong Drawer
  Widget _buildDrawerSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 0, 4),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  /// Item trong Drawer
  Widget _buildDrawerItem(IconData icon, String title, String pageKey) {
    final bool isSelected = _selectedPage == pageKey;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Color(0xFF007BFF) : Colors.grey[700],
      ),
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

  /// Tiêu đề động AppBar
  String _getPageTitle() {
    switch (_selectedPage) {
      case 'home':
        return "Trang chủ";
      case 'rooms':
        return "Phòng trọ";
      case 'finance':
        return "Tài chính";
      case 'chat':
        return "Chat";
      case 'settings':
        return "Cài đặt";
      case 'tenants':
        return "Người thuê";
      case 'invoices':
        return "Hóa đơn";
      case 'reports':
        return "Báo cáo";
      case 'support':
        return "Hỗ trợ";
      default:
        return "Quản lý Nhà trọ";
    }
  }
}
