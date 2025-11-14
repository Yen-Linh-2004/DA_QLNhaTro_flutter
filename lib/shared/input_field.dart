import 'package:flutter/material.dart';

// buildContendField("Mô tả",  "Mô tả chi tiết vấn đề cần sửa chữa...", _discribeController),
Widget buildTextField(String label, String hint, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 6),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    ],
  );
}

// buildContendField("Mô tả",  "Mô tả chi tiết vấn đề cần sửa chữa...", _discribeController, context),
Widget buildContendField(String label, String hint, TextEditingController controller, BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      SizedBox(height: 6),
      TextFormField(
        controller: controller,
        maxLines: 6,
        decoration: InputDecoration(
          hintText: "Mô tả chi tiết vấn đề cần sửa chữa...",
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.2,
            ),
          ),
        ),
      ),
    ],
  );
}

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    var dropdownButtonFormField = DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        dropdownButtonFormField,
      ],
    );
  }
}
