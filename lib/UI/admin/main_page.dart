import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/Home.dart';
import 'package:flutter_application/UI/admin/Rooms/Room.dart';
import 'package:flutter_application/UI/admin/Rooms/booking/booking.dart';
import 'package:flutter_application/UI/admin/Rooms/type_room/type_room.dart';
import 'package:flutter_application/UI/admin/account/account_page.dart';
import 'package:flutter_application/UI/admin/contact/contactPage.dart';
import 'package:flutter_application/UI/admin/customers/customer.dart';
import 'package:flutter_application/UI/admin/devices/devicesPage.dart';
import 'package:flutter_application/UI/admin/generalPage/dashbroad.dart';
import 'package:flutter_application/UI/admin/maintenance/maintenance_page.dart';
import 'package:flutter_application/UI/admin/notifications/notifications_page.dart';
import 'package:flutter_application/UI/admin/paying/payment_page.dart';
import 'package:flutter_application/UI/admin/report/report_page.dart';
import 'package:flutter_application/UI/admin/rule/rule_paging.dart';
import 'package:flutter_application/UI/admin/services/servicesPage.dart';
import 'package:flutter_application/UI/admin/setting.dart';

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

  void _selectPage(String pageKey) {
    setState(() {
      _selectedPage = pageKey;
    });
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF007BFF),
        title: Text(_getPageTitle(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF007BFF), Color(0xFF5AA9FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png")),
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
        return "Tổng quan";
      case 'typeroom':
        return "Quản lý loại phòng";
      case 'rooms':
        return "Quản lý phòng";
      case 'devices':
        return "Quản lý thiết bị";
      case 'settings':
        return "Cài đặt";
      case 'tenants':
        return "Quản lý khách thuê";
      case 'invoices':
        return "Hóa đơn";
      case 'reports':
        return "Báo cáo & Thống kê";
      case 'booking':
        return "Quản lý đặt phòng";
      case 'contact':
        return "Quản lý hợp đồng";
      case 'account':
        return "Quản lý tài khoản";
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
