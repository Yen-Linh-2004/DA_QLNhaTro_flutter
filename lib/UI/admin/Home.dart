import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // HEADER
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: _buildHeader(),
            ),
          ),

          // SECTION TITLE
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: _buildSectionTitle("Tổng Quan"),
            ),
          ),

          // GRID STATS (sliver grid)
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.05,
              ),
              delegate: SliverChildListDelegate([
                StatCard(
                  icon: Icons.apartment_rounded,
                  color: Color(0xFF3A7AFE),
                  value: "48",
                  title: "Tổng số phòng",
                  subtitle: "+2 tháng này",
                ),
                StatCard(
                  icon: Icons.verified_user_outlined,
                  color: Color(0xFF4CCB5F),
                  value: "42",
                  title: "Đã thuê",
                  subtitle: "+5 tháng này",
                ),
                StatCard(
                  icon: Icons.door_back_door_outlined,
                  color: Color(0xFFFFB74D),
                  value: "6",
                  title: "Phòng trống",
                  subtitle: "+3 tháng này",
                ),
                StatCard(
                  icon: Icons.leaderboard_rounded,
                  color: Color(0xFF9B59FF),
                  value: "125.5M",
                  title: "Doanh thu",
                  subtitle: "+12% tháng này",
                ),
              ]),
            ),
          ),

          // HOẠT ĐỘNG GẦN ĐÂY TITLE
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: _buildSectionTitle("Hoạt động gần đây"),
            ),
          ),

          // ACTIVITY LIST
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ActivityItem(
                      icon: Icons.payment_rounded,
                      color: Colors.green,
                      title: "Thanh toán phòng A201",
                      amount: "+3.2M",
                      subtitle: "Trần Thị Lan • 2 phút trước",
                    ),
                    ActivityItem(
                      icon: Icons.login_rounded,
                      color: Colors.blueAccent,
                      title: "Check-in phòng B105",
                      subtitle: "Lê Văn Đức • 15 phút trước",
                    ),
                    ActivityItem(
                      icon: Icons.build_circle_outlined,
                      color: Colors.orangeAccent,
                      title: "Sửa chữa điện C302",
                      subtitle: "1 giờ trước",
                    ),
                    ActivityItem(
                      icon: Icons.description_outlined,
                      color: Colors.purple,
                      title: "Ký hợp đồng mới",
                      subtitle: "Phạm Minh Tuấn • 2 giờ trước",
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  // ================= WIDGETS =================

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3A7AFE), Color(0xFF7A5AF8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Xin chào 👋", style: TextStyle(color: Colors.white70)),
                Text("Nguyễn Văn Minh",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Stack(
            children: [
              Icon(Icons.notifications_none, color: Colors.white, size: 30),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text("3",
                        style:
                            TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}

// ============ COMPONENTS ============

class StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String title;
  final String subtitle;

  const StatCard({
    super.key,
    required this.icon,
    required this.color,
    required this.value,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color, size: 26),
          ),
          SizedBox(height: 6),
          // 🔹 GIẢM TEXT LỚN NẾU QUÁ DÀI
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 4),
          // 🔹 TITLE — CHỐNG TRÀN
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
          SizedBox(height: 4),
          // 🔹 SUBTITLE — CHỐNG TRÀN
          Flexible(
            child: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String amount;

  const ActivityItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    this.amount = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Text(subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          if (amount.isNotEmpty)
            Text(
              amount,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            )
        ],
      ),
    );
  }
}
