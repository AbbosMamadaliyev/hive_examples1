import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 5)
class Todo extends HiveObject {
  @HiveField(0)
  bool complete;
  @HiveField(1)
  String id;
  @HiveField(2)
  String note;
  @HiveField(3)
  String task;

  Todo(
      {required this.complete,
      required this.id,
      required this.note,
      required this.task});
}
