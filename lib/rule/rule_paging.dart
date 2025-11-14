import 'package:flutter/material.dart';

class RuleManagementPage extends StatefulWidget {
  const RuleManagementPage({super.key});

  @override
  State<RuleManagementPage> createState() => _RuleManagementPageState();
}

class _RuleManagementPageState extends State<RuleManagementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ================== DỮ LIỆU NỘI QUY ==================
  final List<Map<String, dynamic>> rules = [
    {
      "title": "Giờ giấc sinh hoạt",
      "description": "Không gây tiếng ồn sau 22:00 và trước 6:00 hằng ngày",
      "category": "Tiếng ồn",
      "status": "Đang áp dụng",
      "date": "1/1/2024",
      "color": Colors.purple.shade100,
    },
    {
      "title": "Vệ sinh chung",
      "description": "Giữ gìn vệ sinh khu vực chung, không vứt rác bừa bãi",
      "category": "Vệ sinh",
      "status": "Đang áp dụng",
      "date": "15/2/2024",
      "color": Colors.green.shade100,
    },
    {
      "title": "Khách thăm",
      "description": "Khách thăm phải đăng ký và không được ở qua đêm",
      "category": "Khách thăm",
      "status": "Đang áp dụng",
      "date": "1/1/2024",
      "color": Colors.blue.shade100,
    },
    {
      "title": "An toàn cháy nổ",
      "description":
          "Sử dụng thiết bị điện tránh chập cháy, gây nổ hoặc hỏa hoạn",
      "category": "An toàn",
      "status": "Đang áp dụng",
      "date": "1/1/2024",
      "color": Colors.red.shade100,
    },
    {
      "title": "Thanh toán tiền thuê",
      "description": "Thanh toán tiền thuê từ ngày 1 đến ngày 5 hằng tháng",
      "category": "Thanh toán",
      "status": "Đang áp dụng",
      "date": "1/1/2024",
      "color": Colors.yellow.shade100,
    },
  ];

  // ================== DỮ LIỆU VI PHẠM ==================
  final List<Map<String, dynamic>> violations = [
    {
      "rule": "Giờ giấc sinh hoạt",
      "tenant": "Đoàn Phan Khánh Huyền",
      "room": "Dãy A - A101",
      "degree": "Vừa",
      "status": "Đã cảnh báo",
      "date": "15/3/2024",
      "reporter": "Hồng Điên"
    },
    {
      "rule": "Vệ sinh chung",
      "tenant": "Lê Trọng Tấn",
      "room": "Dãy A - A105",
      "degree": "Nhẹ",
      "status": "Đã giải quyết",
      "date": "10/3/2024",
      "reporter": "Quản lý"
    },
    {
      "rule": "Thanh toán tiền thuê",
      "tenant": "Phạm Thị Huyền Yến",
      "room": "Dãy A - A301",
      "degree": "Nghiêm trọng",
      "status": "Đã giải quyết",
      "date": "8/3/2024",
      "reporter": "Quản lý"
    },
    {
      "rule": "An toàn cháy nổ",
      "tenant": "Hoàng Văn Kim",
      "room": "Dãy A - A203",
      "degree": "Rất nghiêm trọng",
      "status": "Đã báo cáo",
      "date": "20/3/2024",
      "reporter": "Quản lý"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TabBar
            TabBar(
              controller: _tabController,
              labelColor: Colors.deepPurple,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.deepPurple,
              tabs: const [
                Tab(text: "Nội quy"),
                Tab(text: "Vi phạm"),
              ],
            ),

            const SizedBox(height: 12),

            // Nội dung 2 tab
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildRulesTab(),
                  _buildViolationsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        icon: const Icon(Icons.add),
        label: Text(
          _tabController.index == 0 ? "Thêm nội quy" : "Thêm vi phạm",
        ),
        onPressed: () {
          if (_tabController.index == 0) {
            // Action khi ở tab Nội quy
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const AddRulePage()),
            // );
          } else {
            // Action khi ở tab Vi phạm
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const AddViolationPage()),
            // );
          }
        },
      ),
    );
  }

  // -------------------- TAB 1: NỘI QUY --------------------
  Widget _buildRulesTab() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatCard(
                icon: Icons.description,
                color: Colors.blue.shade100,
                title: "Tổng nội quy",
                value: "4"),
            _buildStatCard(
                icon: Icons.check_circle,
                color: Colors.green.shade100,
                title: "Đang áp dụng",
                value: "5"),
            _buildStatCard(
                icon: Icons.error_outline,
                color: Colors.red.shade100,
                title: "Vi phạm tháng này",
                value: "4"),
          ],
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text("Danh sách nội quy",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: rules.length,
            itemBuilder: (context, index) {
              final rule = rules[index];
              return _buildRuleCard(rule);
            },
          ),
        ),
      ],
    );
  }

  // -------------------- TAB 2: VI PHẠM --------------------
  Widget _buildViolationsTab() {
    return Column(
      children: [
        // Thống kê đầu trang
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatCard(
                icon: Icons.pending_actions,
                color: Colors.amber.shade100,
                title: "Chờ xử lý",
                value: "1"),
            _buildStatCard(
                icon: Icons.notifications_active,
                color: Colors.blue.shade100,
                title: "Đã cảnh báo",
                value: "1"),
            _buildStatCard(
                icon: Icons.check_circle,
                color: Colors.green.shade100,
                title: "Đã giải quyết",
                value: "2"),
          ],
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text("Danh sách vi phạm",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: violations.length,
            itemBuilder: (context, index) {
              final v = violations[index];
              return _buildViolationCard(v);
            },
          ),
        ),
      ],
    );
  }

  // -------------------- CÁC WIDGET DÙNG CHUNG --------------------
  Widget _buildStatCard({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: color,
              child: Icon(icon, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleCard(Map<String, dynamic> rule) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(rule["title"],
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(rule["description"], style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildChip(rule["category"], rule["color"]),
              const SizedBox(width: 8),
              _buildStatusChip(rule["status"]),
              const Spacer(),
              Text(
                rule["date"],
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility, color: Colors.blue)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, color: Colors.green)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete, color: Colors.red)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildViolationCard(Map<String, dynamic> v) {
    Color degreeColor;
    switch (v["degree"]) {
      case "Nhẹ":
        degreeColor = Colors.green.shade100;
        break;
      case "Vừa":
        degreeColor = Colors.yellow.shade100;
        break;
      case "Nghiêm trọng":
        degreeColor = Colors.orange.shade100;
        break;
      default:
        degreeColor = Colors.red.shade100;
    }

    Color statusColor;
    switch (v["status"]) {
      case "Đã cảnh báo":
        statusColor = Colors.blue.shade100;
        break;
      case "Đã giải quyết":
        statusColor = Colors.green.shade100;
        break;
      default:
        statusColor = Colors.orange.shade100;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(v["rule"],
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text("${v["tenant"]}\n${v["room"]}",
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildChip(v["degree"], degreeColor),
              const SizedBox(width: 8),
              _buildChip(v["status"], statusColor),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(v["date"],
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text("Bởi: ${v["reporter"]}",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              )
            ],
          ),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility, color: Colors.blue)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_active,
                      color: Colors.amber)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete, color: Colors.red)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }

  Widget _buildStatusChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child:
          Text(text, style: const TextStyle(fontSize: 12, color: Colors.green)),
    );
  }
}
