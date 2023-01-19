import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'memo.g.dart';

@Collection()
@JsonSerializable()
class Memo {
  late Id uid = Isar.autoIncrement;
  String? id;
  late String title;
  late String memo;
  DateTime created = DateTime.now();
  late DateTime updated = DateTime.now();
  bool status = true;

  Memo({required this.title, required this.memo});

  factory Memo.fromRecord(RecordModel record) => Memo.fromJson(record.toJson());

  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);

  Map<String, dynamic> toJson() => _$MemoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Memo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          uid == other.uid;

  @override
  int get hashCode => id.hashCode ^ uid.hashCode;
}
