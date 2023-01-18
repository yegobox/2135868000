import 'package:backup/models/memo.dart';
import 'package:backup/services/isar_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pocketbase/pocketbase.dart';

class RemoteService {
  static final isarService = IsarService();
  static final pb = PocketBase(dotenv.env["POCKETBASE_SERVER"]!);

  static void putInSync() {
    pb.collection("memos").subscribe(
        "*", (e) => isarService.saveMemo(Memo.fromRecord(e.record!)));
  }

  Future<List<RecordModel>> getMemos() {
    return pb.collection("memos").getFullList();
  }

  Future<void> createMemo(Memo newMemo) async {
    pb.collection("memos").create(body: newMemo.toJson());
  }

  Future<void> updateMemo(Memo updatedMemo) {
    return pb
        .collection("memos")
        .update(updatedMemo.id!, body: updatedMemo.toJson());
  }
}
