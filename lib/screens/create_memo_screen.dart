import 'package:backup/models/memo.dart';
import 'package:backup/services/isar_service.dart';
import 'package:backup/widgets/memo_form.dart';
import 'package:backup/widgets/toaster.dart';
import 'package:flutter/material.dart';

class CreateMemo extends StatelessWidget {
  CreateMemo({super.key});
  final service = IsarService();

  static const route_name = "/create_memo";

  void _createMemo(context, Memo memo) {
    try {
      service.saveMemo(memo);
      Toaster(context).showToast(ToasterType.success, "${memo.title} Saved");
      Navigator.pop(context);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Write a memo"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: MemoForm(submit: (memo) => _createMemo(context, memo)),
          ),
        ),
      ),
    );
  }
}
