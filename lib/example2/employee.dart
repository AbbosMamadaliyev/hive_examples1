import 'package:hive_flutter/hive_flutter.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee {
  @HiveField(0)
  String empName;

  @HiveField(1)
  String empSalary;

  @HiveField(2)
  String empAge;

  Employee(
      {required this.empName, required this.empSalary, required this.empAge});
}
