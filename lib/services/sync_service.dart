import 'dart:collection';

import 'package:backup/models/memo.dart';
import 'package:backup/services/isar_service.dart';
import 'package:backup/services/remote_service.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:stock/stock.dart';

final isarService = IsarService();
final remoteService = RemoteService();

class IsarSourceOfTruth implements SourceOfTruth<String, List<Memo>> {
  @override
  Stream<List<Memo>> reader(String key) async* {
    yield* isarService.getAllMemos();
  }

  @override
  Future<void> write(String key, List<Memo>? memos) async {
    List<Memo> localMemos = await isarService.getMemos();
    var localMemosSet = HashSet<Memo>.from(localMemos);
    var remoteMemosSet = HashSet<Memo>.from(memos!);
    var difference = localMemosSet.difference(remoteMemosSet);
    if (difference.isNotEmpty) {
      difference.forEach((Memo memo) {
        if (memo.id!.isEmpty) remoteService.createMemo(memo);
      });
    }
    memos = memos.map((Memo memo) {
      var existingMemo = localMemos.firstWhere((e) => e.uid == memo.uid,
          orElse: () => Memo(title: "Notfound", memo: "Notfound"));
      if (existingMemo.title != "Notfound") {
        if (existingMemo.updated.microsecondsSinceEpoch >
            memo.updated.millisecondsSinceEpoch) {
          print(memo.toJson());
          print(existingMemo.toJson());
          remoteService.updateMemo(existingMemo);
          return existingMemo;
        }
      }
      return memo;
    }).toList();
    // return isarService.saveMemos(memos);
  }

  @override
  Future<void> delete(String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }
}

final pocketBaseFetcher = Fetcher.ofFuture<String, List<Memo>>((key) async {
  final memos = await remoteService.getMemos();
  final memosJson = memos.map((RecordModel memo) {
    return Memo.fromRecord(memo);
  }).toList();
  return memosJson;
});

final stock =
    Stock(fetcher: pocketBaseFetcher, sourceOfTruth: IsarSourceOfTruth());
