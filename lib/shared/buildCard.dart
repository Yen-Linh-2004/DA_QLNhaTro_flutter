import 'package:flutter/material.dart';

  // BUILD CARD
  // buildSummaryCard(Icons.check_circle, "Đã thu", "11.835.000đ", Colors.green),
  Widget buildSummaryCard(IconData icon, String title, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: color)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // BUILD BUTTON
  // buildActionBtn(Icons.check, "Hoàn thành", Colors.green, (){}),
  Widget buildActionBtn(IconData? icon, String text, Color color, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }