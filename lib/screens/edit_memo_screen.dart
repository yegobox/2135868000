import 'package:backup/services/isar_service.dart';
import 'package:backup/widgets/memo_form.dart';
import 'package:flutter/material.dart';

class EditMemo extends StatelessWidget {
  EditMemo({super.key});
  final isarService = IsarService();

  static const route_name = "/edit_memo";

  void updateMemo(context, memo) async {
    await isarService.updateMemo(memo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final memoId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Memo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: MemoForm(
          submit: (memo) {
            updateMemo(context, memo);
          },
          initialMemoId: memoId,
        ),
      ),
    );
  }
}
