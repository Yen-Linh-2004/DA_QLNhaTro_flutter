import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // cần thêm gói này trong pubspec.yaml

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  String selectedMonth = "Tháng 11 / 2025";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Báo cáo tài chính",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bộ chọn tháng
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tổng quan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedMonth,
                  items: [
                    "Tháng 11 / 2025",
                    "Tháng 10 / 2025",
                    "Tháng 9 / 2025",
                    "Tháng 8 / 2025",
                  ]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tổng quan doanh thu / chi phí / lợi nhuận
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryCard("Doanh thu", "45.2M", Colors.green),
                _buildSummaryCard("Chi phí", "18.7M", Colors.redAccent),
                _buildSummaryCard("Lợi nhuận", "26.5M", Colors.blue),
              ],
            ),

            const SizedBox(height: 24),
            const Text(
              "Biểu đồ thu chi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Biểu đồ cột (thu / chi theo tuần)
            SizedBox(
              height: 220,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final weeks = ["Tuần 1", "Tuần 2", "Tuần 3", "Tuần 4"];
                          return Text(weeks[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(toY: 10, color: Colors.green, width: 16),
                      BarChartRodData(toY: 5, color: Colors.redAccent, width: 16),
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(toY: 8, color: Colors.green, width: 16),
                      BarChartRodData(toY: 4, color: Colors.redAccent, width: 16),
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(toY: 9, color: Colors.green, width: 16),
                      BarChartRodData(toY: 6, color: Colors.redAccent, width: 16),
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(toY: 12, color: Colors.green, width: 16),
                      BarChartRodData(toY: 5, color: Colors.redAccent, width: 16),
                    ]),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              "Giao dịch gần đây",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildTransactionItem(
              Icons.trending_up,
              "Thu tiền phòng A201",
              "+3.2M",
              "2 phút trước",
              Colors.green,
            ),
            _buildTransactionItem(
              Icons.trending_down,
              "Thanh toán sửa điện B302",
              "-1.2M",
              "15 phút trước",
              Colors.redAccent,
            ),
            _buildTransactionItem(
              Icons.trending_up,
              "Thu tiền đặt cọc phòng C101",
              "+5.0M",
              "1 giờ trước",
              Colors.green,
            ),
            _buildTransactionItem(
              Icons.trending_down,
              "Mua thiết bị vệ sinh chung",
              "-0.8M",
              "2 giờ trước",
              Colors.redAccent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.blue,
        label: const Text("Thêm giao dịch"),
        icon: const Icon(Icons.add),
      ),
    );
  }

  // Ô tổng quan
  Widget _buildSummaryCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Item giao dịch
  Widget _buildTransactionItem(
      IconData icon, String title, String amount, String time, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
