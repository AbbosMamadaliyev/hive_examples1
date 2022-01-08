import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 3)
class DataModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool complete;

  DataModel(
      {required this.title, required this.description, required this.complete});
}
