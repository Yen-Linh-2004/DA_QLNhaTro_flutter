import 'package:flutter/material.dart';
class BookingDetailPage extends StatelessWidget {
  const BookingDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(
          "Chi tiết đặt phòng", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 22, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCard(
              title: "Thông tin khách hàng",
              children: [
                _buildInfoRow("Họ tên", "Hoàng Văn E"),
                _buildInfoRow("Số điện thoại", "0913456789"),
                _buildInfoRow("Email", "hoangvane@email.com"),
              ],
            ),

            SizedBox(height: 20),

            _buildCard(
              title: "Thông tin đặt phòng",
              children: [
                _buildInfoRow("Phòng", "P103"),
                _buildInfoRow("Ngày nhận phòng", "1/4/2024"),
                _buildInfoRow("Thời hạn", "12 tháng"),
                _buildInfoRow("Tiền cọc", "7.000.000đ", highlight: true),
              ],
            ),

            SizedBox(height: 20),

            _buildCard(
              title: "Ghi chú",
              children: [
                TextField(
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: "Khách yêu cầu phòng tầng 1...",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Xác nhận",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),

                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Từ chối",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------
  // 🔹 CARD SECTION
  // -------------------------
  Widget _buildCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  // -------------------------
  // 🔹 INFO ROW
  // -------------------------
  Widget _buildInfoRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: highlight ? Colors.green : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
