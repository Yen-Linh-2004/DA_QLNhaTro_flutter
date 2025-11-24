import 'package:flutter/material.dart';

// BUILD CARD
// buildSummaryCard(Icons.check_circle, "Đã thu", "11.835.000đ", Colors.green),
Widget buildSummaryCard(
  IconData icon,
  String title,
  String value,
  Color color,
) {
  return Container(
    decoration: BoxDecoration(
      // ignore: deprecated_member_use
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
    ),
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 30),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, color: color),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

// BUILD BUTTON
// buildActionBtn(Icons.check, "Hoàn thành", Colors.green, (){}),
Widget buildActionBtn(
  IconData? icon,
  String text,
  Color color,
  VoidCallback onPressed,
) {
  return Expanded(
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
    ),
  );
}

void showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onConfirm,
  Color confirmColor = Colors.blue,
  String confirmText = "Xác nhận",
  String cancelText = "Hủy",
  IconData? icon,
  double maxHeight = 200,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: SingleChildScrollView(child: Text(message)),
        ),

        title: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: confirmColor),
              SizedBox(width: 6),
            ],
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              softWrap: true,
              overflow: TextOverflow.visible,
              maxLines: null,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(cancelText, style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: confirmColor),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: Text(confirmText, style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

Widget infoCard(List<Widget> children) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 3,
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(children: children),
    ),
  );
}

Widget infoRow(String label, String value, {bool bold = false, Color? color}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        SizedBox(
          width: 130,
          child: Text(label, style: TextStyle(color: Colors.grey[700])),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}
