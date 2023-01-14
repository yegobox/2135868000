import 'package:backup/widgets/memo_form.dart';
import 'package:flutter/material.dart';

class EditMemo extends StatelessWidget {
  const EditMemo({super.key});

  static const route_name = "/edit_memo";

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
          submit: (memo) {},
          initialMemoId: memoId,
        ),
      ),
    );
  }
}
