import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/generalPage/dashbroad.dart';
import 'package:flutter_application/UI/users/RepairRequestDetail/RepairRequest.dart';
import 'package:flutter_application/UI/users/bill.dart';
import 'package:flutter_application/UI/users/contact.dart';
import 'package:flutter_application/UI/users/homePage.dart';
import 'package:flutter_application/UI/users/rulesandviolations.dart';
import 'package:flutter_application/UI/users/usermyroom.dart';

const Color kPrimaryColor = Color(0xFF00ADB5);
const Color kAccentColor = Color(0xFFFF5722);
const Color kBackgroundColor = Color(0xFFEEEEEE);

class TenantHomePage extends StatefulWidget {
  const TenantHomePage({super.key});
  @override
  State<TenantHomePage> createState() => _TenantHomePage();
}

class _TenantHomePage extends State<TenantHomePage> {
  String _selectedPage = 'home';
  late String pageKey;

  final Map<String, Widget> _pages = const {
    'home': InvoiceListPage(),
    'room': RoomPage(),
    'contact': ContractPage(),
    'bill': BillPage(),
    'maintenance': RepairRequestPage(),
    'rule': RulesAndViolationsPage()
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(_getPageTitle(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: kPrimaryColor,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_selectedPage],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Yến Linh", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                accountEmail: Text("yenlinh@gmail.com", style: TextStyle(color: Colors.white70)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset("lib/assets/images/log.png", width: 80, height: 80, fit: BoxFit.cover),
                  ),
                ),
                decoration: BoxDecoration(color: kPrimaryColor),
              ),
              _buildDrawerItem(Icons.home_outlined, "Trang chủ", 'home'),
              _buildDrawerItem(Icons.meeting_room_outlined, "Phòng của tôi", 'room'),
              _buildDrawerItem(Icons.receipt_long, "Hóa đơn", 'bill'),
              _buildDrawerItem(Icons.description_outlined, "Hợp đồng", 'contact'),
              _buildDrawerItem(Icons.build_circle_outlined, "Nội quy và vi phạm", 'rule'),
              _buildDrawerItem(Icons.build_circle_outlined, "Yêu cầu bảo trì", 'maintenance'),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: kAccentColor),
                title: Text("Đăng xuất", style: TextStyle(color: kAccentColor, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeMobilePage()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Item trong Drawer
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
}

// class TenantHomeContentPage extends StatelessWidget {
//   const TenantHomeContentPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _roomInfoCard(context),
//             SizedBox(height: 25),
//             _sectionTitle("Chức năng nhanh", Icons.dashboard_customize_outlined),
//             SizedBox(height: 15),
//             _quickActionGrid(context),
//             SizedBox(height: 25),
//             _sectionTitle("Thông báo gần đây", Icons.notifications_active_outlined),
//             SizedBox(height: 10),
//             _notificationList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _roomInfoCard(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.white, Colors.grey.shade100],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 6,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(18),
//         child: Row(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: kPrimaryColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: EdgeInsets.all(12),
//               child: Icon(Icons.meeting_room_rounded, size: 40, color: kPrimaryColor),
//             ),
//             SizedBox(width: 18),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Phòng 101A", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
//                   SizedBox(height: 4),
//                   Text("Tình trạng: Đang thuê", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
//                   SizedBox(height: 4),
//                   Text("Hết hạn: 10/12/2025", style: TextStyle(color: kAccentColor, fontSize: 13)),
//                 ],
//               ),
//             ),
//             Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.grey),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _sectionTitle(String title, IconData icon) {
//     return Row(
//       children: [
//         Icon(icon, size: 22, color: kPrimaryColor),
//         SizedBox(width: 8),
//         Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87)),
//       ],
//     );
//   }

//   Widget _quickActionGrid(BuildContext context) {
//     final List<Map<String, dynamic>> actions = [
//       {
//         "icon": Icons.receipt_long,
//         "label": "Hóa đơn",
//         "color": Colors.orange,
//         "onTap": () {},
//       },
//       {
//         "icon": Icons.build_circle,
//         "label": "Yêu cầu sửa chữa",
//         "color": kAccentColor,
//         "onTap": () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (c) => const RepairRequestPage()),
//           );
//         },
//       },
//       {
//         "icon": Icons.payments,
//         "label": "Thanh toán",
//         "color": Colors.green,
//         "onTap": () {},
//       },
//       {
//         "icon": Icons.support_agent_outlined,
//         "label": "Liên hệ",
//         "color": kPrimaryColor,
//         "onTap": () {},
//       },
//     ];

//     return GridView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: actions.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisExtent: 120,
//         crossAxisSpacing: 15,
//         mainAxisSpacing: 15,
//       ),
//       itemBuilder: (context, index) {
//         final action = actions[index];
//         return InkWell(
//           onTap: action["onTap"],
//           borderRadius: BorderRadius.circular(18),
//           splashColor: Colors.white24,
//           child: Container(
//             decoration: BoxDecoration(
//               color: action["color"],
//               borderRadius: BorderRadius.circular(18),
//               boxShadow: [
//                 BoxShadow(color: action["color"].withOpacity(0.3), blurRadius: 6, offset: Offset(0, 4)),
//               ],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(action["icon"], size: 40, color: Colors.white),
//                 SizedBox(height: 10),
//                 Text(
//                   action["label"],
//                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _notificationList() {
//     final List<Map<String, dynamic>> notifications = [
//       {
//         "title": "Cắt điện bảo trì",
//         "content": "Ngày 12/11 sẽ cắt điện từ 8h - 10h sáng.",
//         "icon": Icons.electrical_services_outlined,
//         "color": Colors.amber.shade700,
//       },
//       {
//         "title": "Lịch thu tiền phòng",
//         "content": "Thu tiền phòng vào ngày 5 hàng tháng.",
//         "icon": Icons.calendar_today_outlined,
//         "color": kPrimaryColor,
//       },
//       {
//         "title": "Thông báo vệ sinh khu chung",
//         "content": "Ngày 13/11 sẽ dọn dẹp khu hành lang tầng 1.",
//         "icon": Icons.cleaning_services_outlined,
//         "color": Colors.green,
//       },
//     ];
//     return Column(
//       children: notifications.map((n) {
//         return Card(
//           elevation: 2,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           margin: EdgeInsets.only(bottom: 10),
//           child: ListTile(
//             leading: CircleAvatar(backgroundColor: n["color"].withOpacity(0.1)),
//             title: Text(n["title"], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 15)),
//             subtitle: Text(n["content"], style: TextStyle(color: Colors.black54, fontSize: 13)),
//             trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
//             onTap: () {},
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
