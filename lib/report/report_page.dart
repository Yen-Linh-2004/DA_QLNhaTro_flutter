import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        // title: Text("Báo cáo thống kê"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Báo cáo"),
            Tab(text: "Thống kê"),
          ],
        ),
      ),
      
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildDetailTab(),
        ],
      ),
    );
  }

  // TAB 1 ───────────────────────────────────────────
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Dropdown chọn năm
            Row(
              children: [
                 Text("Năm:", style: TextStyle(fontSize: 16)),
                 SizedBox(width: 12),
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: "2024",
                      items:  [
                        DropdownMenuItem(value: "2024", child: Text("2024")),
                        DropdownMenuItem(value: "2023", child: Text("2023")),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                )
              ],
            ),

            //  SizedBox(height: 20),

            // GridView.count(
            //   crossAxisCount: 2,
            //   crossAxisSpacing: 12,
            //   mainAxisSpacing: 12,
            //   shrinkWrap: true,
            //   physics:  NeverScrollableScrollPhysics(),
            //   children: [
            //     buildSummaryCard(Icons.check_circle, "Đã thu", "11.835.000đ", Colors.green),
            //     buildSummaryCard(Icons.schedule, "Chưa thu", "15.415.000đ", Colors.orange),
            //     buildSummaryCard(Icons.warning_amber, "Quá hạn", "1", Colors.red),
            //     buildSummaryCard(Icons.receipt_long, "Tổng hóa đơn", "6", Colors.blue),
            //   ],
            // ),
             SizedBox(height: 20),
            _buildRevenueBars(),
             SizedBox(height: 25),
            /// Top phòng doanh thu cao
            _buildSectionTitle("Top phòng doanh thu cao"),
             SizedBox(height: 10),
            _buildTopRooms(),
             SizedBox(height: 25),
            /// Giao dịch gần đây
            _buildSectionTitle("Giao dịch thu tiền gần đây"),
             SizedBox(height: 10),
            _buildTransactions(),
          ],
        ),
    );
  }

  // TAB 2 ───────────────────────────────────────────
  Widget _buildDetailTab() {
    return SingleChildScrollView(
      padding:  EdgeInsets.all(16),
      child: Column(
        children: [
          _summaryCard(),
          SizedBox(height: 16),
          /// Biểu đồ doanh thu tháng
          _revenueBarChart(),
          SizedBox(height: 10),
          // Biểu đồ tỉ lệ lấp đầy
          _occupancyBarChart(),
          SizedBox(height: 16),
          _detailOccupancyList(),
          SizedBox(height: 16),
          _monthlyCompareSection(),
        ],
      )
    );
  }

  // WIDGETS ─────────────────────────────────────────
  Widget _summaryCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tháng 10/2024", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _metricBox("Doanh thu", "52.000.000đ", Colors.blue),
              _metricBox("Tỷ lệ lấp đầy", "95%", Colors.green),
            ],
          )
        ],
      ),
    );
  }

  Widget _metricBox(String title, String value, Color color) {
    return Container(
      width: 170,
      height: 90,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
        // ignore: deprecated_member_use
        border: Border.all(color: color.withOpacity(.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14)),
          SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
  // Danh sách chi tiết lấp đầy
  Widget _detailOccupancyList() {
    final items = [
      ["Tổng số phòng", "20"],
      ["Phòng đã đặt", "10"],
      ["Phòng trống", "6"],
      ["Khách trả mới", "4"],
      ["Lượt dọn vệ sinh", "2"],
    ];

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Chỉ tiết lấp đầy", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...items.map((e) => _detailItem(e[0], e[1])),
        ],
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // So sánh theo tháng
  Widget _monthlyCompareSection() {
    final compare = [
      ["Tháng 10/2024", "52.000.000đ", "95%", "3"],
      ["Tháng 09/2024", "42.000.000đ", "88%", "2"],
      ["Tháng 08/2024", "32.500.000đ", "78%", "4"],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("So sánh theo tháng", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ...compare.map((e) => _monthlyCard(e)),
      ],
    );
  }

  Widget _monthlyCard(List<String> data) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data[0], style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _detailItem("Doanh thu", data[1]),
          _detailItem("Tỷ lệ lấp đầy", data[2]),
          _detailItem("Số đơn huỷ", data[3]),
        ],
      ),
    );
  }

// ---------------------------- WIDGETS -----------------------------
  Widget _buildSectionTitle(String title) {
    return Text(title,
        style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

// Biểu đồ thanh ngang doanh thu
  Widget _buildRevenueBars() {
    final months = [
      {"month": "T1", "value": 62.0},
      {"month": "T2", "value": 64.5},
      {"month": "T3", "value": 63.8},
      {"month": "T4", "value": 66.2},
      {"month": "T5", "value": 67.1},
      {"month": "T6", "value": 68.9},
      {"month": "T7", "value": 70.2},
      {"month": "T8", "value": 69.8},
      {"month": "T9", "value": 71.5},
      {"month": "T10", "value": 72.3},
      {"month": "T11", "value": 68.5},
    ];

    double maxValue = 72.3;

    return Column(
      children: months.map((m) {
        double percent = (m["value"] as double) / maxValue;
        return Container(
          margin:  EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              SizedBox(width: 30, child: Text(m["month"] as String)),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: percent,
                      child: Container(
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               SizedBox(width: 10),
              SizedBox(
                width: 60,
                child: Text("${m["value"]}M",
                    textAlign: TextAlign.right,
                    style:  TextStyle(fontSize: 13)),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

// Danh sách top phòng doanh thu cao
  Widget _buildTopRooms() {
    final rooms = [
      {"room": "Phòng 201", "value": "4.2M"},
      {"room": "Phòng 203", "value": "4.0M"},
      {"room": "Phòng 301", "value": "3.8M"},
      {"room": "Phòng 302", "value": "3.6M"},
      {"room": "Phòng 101", "value": "3.5M"},
    ];

    return Column(
      children: rooms.map((r) {
        int index = rooms.indexOf(r) + 1;

        return Container(
          padding:  EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          margin:  EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepPurple.shade100,
                child: Text(index.toString(),
                    style:  TextStyle(color: Colors.deepPurple)),
              ),
               SizedBox(width: 12),
              Expanded(child: Text(r["room"]!)),
              Text(r["value"]!,
                  style:  TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }

// Danh sách giao dịch gần đây
  Widget _buildTransactions() {
    final items = [
      {"text": "Thu tiền phòng 201 - Tháng 1", "value": "+4.2M"},
      {"text": "Thu tiền phòng 203 - Tháng 1", "value": "+4.0M"},
      {"text": "Thu tiền phòng 301 - Tháng 1", "value": "+3.8M"},
    ];

    return Column(
      children: items.map((t) {
        return Container(
          padding:  EdgeInsets.all(14),
          margin:  EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
               Icon(Icons.check_circle, color: Colors.green),
               SizedBox(width: 12),
              Expanded(child: Text(t["text"]!)),
              Text(t["value"]!,
                  style:  TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Biểu đồ doanh thu theo tháng
  Widget _revenueBarChart() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Doanh thu theo tháng", 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 0: return Text("T7");
                          case 1: return Text("T8");
                          case 2: return Text("T9");
                        }
                        return Text("");
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [BarChartRodData(toY: 52, color: Colors.blue, width: 26)],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(toY: 48, color: Colors.blue, width: 26)],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(toY: 60, color: Colors.blue, width: 26)],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Biểu đồ tỉ lệ lấp đầy
  Widget _occupancyBarChart() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tỷ lệ lấp đầy", 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 0: return Text("K1");
                          case 1: return Text("K2");
                          case 2: return Text("K3");
                        }
                        return Text("");
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [BarChartRodData(toY: 85, color: Colors.green, width: 26)],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(toY: 88, color: Colors.green, width: 26)],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(toY: 90, color: Colors.green, width: 26)],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
