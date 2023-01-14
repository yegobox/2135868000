import 'package:backup/models/memo.dart';
import 'package:backup/widgets/memo_item.dart';
import 'package:flutter/widgets.dart';

class MemoList extends StatelessWidget {
  final List<Memo> memos;

  const MemoList({super.key, required this.memos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: memos.length,
      itemBuilder: (context, index) {
        return MemoItem(memo: memos[index]);
      },
    );
  }
}
