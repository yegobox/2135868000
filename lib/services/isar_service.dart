import 'package:backup/models/memo.dart';
import 'package:isar/isar.dart';

class IsarService {
  late Future<Isar> db;

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
    yield* isar.memos.where().watch(fireImmediately: true);
  }

  Stream<void> getMemo(int id) async* {
    final isar = await db;
    yield* isar.memos.watchObject(id, fireImmediately: true);
  }

  Future<void> saveMemo(Memo newMemo) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.memos.putSync(newMemo));
  }

  Future<bool> deleteMemo(id) async {
    final isar = await db;
    return isar.writeTxnSync<bool>(() => isar.memos.deleteSync(id));
  }
}
