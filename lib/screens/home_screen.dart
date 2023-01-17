import 'package:backup/models/memo.dart';
import 'package:backup/screens/create_memo_screen.dart';
import 'package:backup/services/isar_service.dart';
import 'package:backup/services/remote_service.dart';
import 'package:backup/services/sync_service.dart';
import 'package:backup/widgets/memo_list.dart';
import 'package:flutter/material.dart';
import 'package:stock/stock.dart';

class Home extends StatelessWidget {
  Home({super.key, required this.title});

  final String title;
  final service = IsarService();

  @override
  Widget build(BuildContext context) {
    RemoteService.putInSync();
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
      body: Padding(
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: stock.stream("memos", refresh: true),
          builder: (context, snapshot) {
            return snapshot.data.runtimeType == (StockResponseData<List<Memo>>)
                ? MemoList(
                    memos:
                        (snapshot.data as StockResponseData<List<Memo>>).value)
                : Text("No Memos Saved");
          },
        ),
      ),
    );
  }
}
