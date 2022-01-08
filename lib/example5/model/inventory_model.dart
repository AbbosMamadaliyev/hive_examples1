import 'package:hive/hive.dart';

part 'inventory_model.g.dart';

@HiveType(typeId: 2)
class Inventory {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  Inventory({required this.name, required this.description});
}
