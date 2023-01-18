import 'package:backup/models/memo.dart';
import 'package:backup/services/connectivity_service.dart';
import 'package:backup/services/remote_service.dart';
import 'package:backup/services/sync_service.dart';
import 'package:isar/isar.dart';

class IsarService {
  late Future<Isar> db;
  final remoteService = RemoteService();

  IsarService() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MemoSchema], inspector: true);
    }

    return Future.value(Isar.getInstance());
  }

  Stream<List<Memo>> getAllMemos() async* {
    final isar = await db;
    yield* isar.memos
        .where()
        .filter()
        .statusEqualTo(true)
        .watch(fireImmediately: true);
  }

  Future<List<Memo>> getMemos() async {
    final isar = await db;
    return isar.memos.where().findAll();
  }

  Stream<Memo?> getMemo(int id) async* {
    final isar = await db;
    yield* isar.memos.watchObject(id, fireImmediately: true);
  }

  Future<void> saveMemo(Memo newMemo) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.memos.putSync(newMemo));
  }

  Future<void> saveMemos(List<Memo> newMemos) async {
    final isar = await db;
    isar.writeTxnSync<List<int>>(() => isar.memos.putAllSync(newMemos));
  }

  Future<void> deleteMemo(id) async {
    final isar = await db;
    final memo = await isar.memos.get(id);
    memo!.status = false;
    memo.updated = DateTime.now();
    isar.writeTxnSync(() => isar.memos.putSync(memo));
  }

  Future<void> updateMemo(Memo memo) async {
    final isar = await db;
    memo.updated = DateTime.now();
    isar.writeTxnSync(() => isar.memos.putSync(memo));
    if (ConnectivityService.isConnected) {
      try {
        remoteService.updateMemo(memo);
      } catch (e) {
        return;
      }
    }
  }
}
