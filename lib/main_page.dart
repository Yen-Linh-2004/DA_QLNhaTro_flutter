import 'package:flutter/material.dart';
import 'package:flutter_application/Home.dart';
import 'package:flutter_application/Rooms/Room.dart';
import 'package:flutter_application/Rooms/booking/booking.dart';
import 'package:flutter_application/Rooms/type_room/type_room.dart';
import 'package:flutter_application/account/account_page.dart';
import 'package:flutter_application/contact/contactPage.dart';
import 'package:flutter_application/customers/customer.dart';
import 'package:flutter_application/devices/devicesPage.dart';
import 'package:flutter_application/finance.dart';
import 'package:flutter_application/generalPage/dashbroad.dart';
import 'package:flutter_application/maintenance/maintenance_page.dart';
import 'package:flutter_application/notifications/notifications_page.dart';
import 'package:flutter_application/paying/payment_page.dart';
import 'package:flutter_application/report/report_page.dart';
import 'package:flutter_application/rule/rule_paging.dart';
import 'package:flutter_application/services/servicesPage.dart';
import 'package:flutter_application/setting.dart';

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
    'devices': EquipmentManagementPage(),
    'settings': SystemSettingPage(),
    'tenants': CustomerPage(),
    'account': AccountManagementPage(),
    'notifications': NotificationManagementPage(),
    'paying': PaymentManagementPage(),
    'service': ServiceManagementPage(),
    'rule': RuleManagementPage(),
    'reports': ReportPage(),
    'maintenance': MaintenancePage()
  };

  // // Danh sách trang trong bottom nav
  // final List<String> _bottomNavPages = [
  //   'home',
  //   'rooms',
  //   'finance',
  //   'chat',
  //   'settings',
  // ];

  void _selectPage(String pageKey) {
    setState(() {
      _selectedPage = pageKey;
    });
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  // void _selectBottomItem(String pageKey) {
  //   setState(() {
  //     _selectedPage = pageKey;
  //   });
  //   if (Navigator.canPop(context)) Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    // final currentIndex = _bottomNavPages.indexOf(_selectedPage);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF007BFF),
        title: Text(_getPageTitle(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
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

          _buildDrawerItem(Icons.home_outlined, "Tổng quan", 'home'),
          _buildDrawerItem(Icons.local_offer_outlined, "Loại phòng", 'typeroom',),
          _buildDrawerItem(Icons.meeting_room_outlined, "Phòng trọ", 'rooms'),
          _buildDrawerItem(Icons.people_outline, "Khách thuê", 'tenants'),
          _buildDrawerItem(Icons.attach_money_outlined, "Đặt phòng", 'booking'),
          _buildDrawerItem(Icons.contact_emergency, "Hợp đồng", 'contact'),
          _buildDrawerItem(Icons.payment_outlined, "Thanh toán", 'paying'),
          _buildDrawerItem(Icons.design_services, "Dịch vụ", 'service'),
          _buildDrawerItem(Icons.support_agent_outlined, "Bảo trì", 'maintenance'),
          _buildDrawerItem(Icons.electrical_services, "Thiết bị", 'devices'),
          _buildDrawerItem(Icons.bar_chart_outlined, "Báo cáo & Thống kê", 'reports'),
          
          _buildDrawerItem(Icons.running_with_errors_rounded, "Nội quy và vi phạm", 'rule'),
          _buildDrawerItem(Icons.notifications, "Thông báo", 'notifications'),
          _buildDrawerItem(Icons.receipt_long_outlined, "Tài khoản", 'account'),
          _buildDrawerItem(Icons.settings_outlined, "Cài đặt", 'settings'),
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
      case 'typeroom':
        return "Danh sách loại phòng";
      case 'rooms':
        return "Phòng trọ";
      case 'finance':
        return "Tài chính";
      case 'devices':
        return "Danh sách các thiết bị";
      case 'settings':
        return "Cài đặt";
      case 'tenants':
        return "Người thuê";
      case 'invoices':
        return "Hóa đơn";
      case 'reports':
        return "Báo cáo & Thống kê";
      case 'support':
        return "Hỗ trợ";
      case 'booking':
        return "Đặt phòng";
      case 'contact':
        return "Danh sách hợp đồng";
      case 'account':
        return "Thông tin tài khoản";
      case 'notifications':
        return "Quản lý thông báo";
      case 'paying':
        return "Quản lý thanh toán";
      case 'service':
        return "Quản lý dịch vụ";
      case 'rule':
        return "Nội quy & vi phạm";
      case 'maintenance':
        return "Quản lý bảo trì";
      default:    
        return "Quản lý Nhà trọ";
    }
  }
}
