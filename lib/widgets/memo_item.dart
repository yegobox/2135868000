import 'package:backup/helpers/timestamp_helper.dart';
import 'package:backup/models/memo.dart';
import 'package:backup/screens/edit_memo_screen.dart';
import 'package:backup/screens/view_memo_screen.dart';
import 'package:backup/services/isar_service.dart';
import 'package:flutter/material.dart';

class MemoItem extends StatelessWidget {
  final Memo memo;
  final service = IsarService();

  MemoItem({required this.memo});

  void viewMemo(context, Memo memo) {
    Navigator.pushNamed(context, ViewMemo.route_name, arguments: memo);
  }

  void editMemo(context, int id) =>
      Navigator.pushNamed(context, EditMemo.route_name, arguments: id);

  void deleteMemo(int id) async {
    await service.deleteMemo(id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.7,
      color: Color.fromARGB(255, 15, 21, 31),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(22, 255, 255, 255)),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () => viewMemo(context, memo),
            leading: Text(memo.uid.toString()),
            title: Text(
              memo.title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: SizedBox(
                width: 80,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => editMemo(context, memo.uid),
                      icon: Icon(Icons.edit),
                      color: Color.fromARGB(255, 248, 161, 31),
                      iconSize: 20,
                    ),
                    IconButton(
                      onPressed: () => deleteMemo(memo.uid),
                      icon: Icon(Icons.delete),
                      iconSize: 20,
                      color: Color.fromARGB(255, 231, 66, 55),
                    )
                  ],
                )),
            horizontalTitleGap: 2,
            subtitle: Text(
                "Upadated ${getTimeAgo(memo.updated.millisecondsSinceEpoch)} ago"),
          ),
        ),
      ),
    );
  }
}
