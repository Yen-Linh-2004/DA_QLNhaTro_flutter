import 'package:flutter/material.dart';
import 'package:flutter_application/UI/admin/shared/buildCard.dart';
import 'package:flutter_application/UI/admin/shared/input_field.dart';
class AddRulePage extends StatefulWidget {
  const AddRulePage({super.key});

  @override
  State<AddRulePage> createState() => _AddRulePageState();
}

class _AddRulePageState extends State<AddRulePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _decribeController = TextEditingController();

  String? selectedtype = "Chọn danh mục";
  final List<String> type = ["Chọn danh mục", "Chung", "An toàn", "Tiếng ồn", "Khách thăm", "Thanh toán"];
  bool apply = false;

  @override
  void dispose() {
    _titleController.dispose();
    _decribeController.dispose();
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Thêm nội quy mới", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        padding:  EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField("Tiêu đề", "Tiêu đề nội quy", _titleController),
              SizedBox(height: 16),
              buildContendField("Mô tả", "Nôi tả chi tiết nội quy", _decribeController, context),
              SizedBox(height: 16),
              CustomDropdown(label: "Danh mục", value: selectedtype, items: type,
                onChanged: (value) {
                  setState(() {
                    selectedtype = value;
                  });
                }
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: apply,
                    checkColor: Color.fromARGB(115, 46, 46, 46),
                    onChanged: (value) {
                      setState(() {
                        apply = value ?? false;
                      });
                    },
                  ),
                  Text("Đang áp dụng", style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
              SizedBox(height: 24),

              // Nút hành động
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildActionBtn(Icons.close, "Hủy", Colors.red, () => Navigator.pop(context)),
                  SizedBox(width: 16),
                  buildActionBtn(Icons.add, "Thêm nội quy", Colors.blue, (){}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
