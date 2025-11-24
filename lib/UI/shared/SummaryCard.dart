
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final SummaryItem item;
  const SummaryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding:  EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(item.icon, size: 32, color: item.color),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.title,
                    style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                FittedBox(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: item.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Data Models
class SummaryItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  SummaryItem(this.title, this.value, this.icon, this.color);
}