import 'package:isar/isar.dart';

part 'memo.g.dart';

@Collection()
class Memo {
  late Id id = Isar.autoIncrement;

  late String title;
  late String memo;
  DateTime createdAt = DateTime.now();
  late DateTime updatedAt = DateTime.now();

  Memo({required this.title, required this.memo});
}
