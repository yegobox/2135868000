import 'package:backup/models/memo.dart';
import 'package:backup/screens/create_memo_screen.dart';
import 'package:backup/services/isar_service.dart';
import 'package:backup/widgets/memo_list.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key, required this.title});

  final String title;
  final service = IsarService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CreateMemo.route_name);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: StreamBuilder(
            stream: service.getAllMemos(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? MemoList(
                      memos: snapshot.data as List<Memo>,
                    )
                  : Text("No Memos Saved");
            },
          ),
        ),
      ),
    );
  }
}
