import 'package:hive/hive.dart';

part 'user_data_model.g.dart';

@HiveType(typeId: 4)
class UserData {
  @HiveField(0)
  String userName;

  @HiveField(1)
  String password;

  @HiveField(2)
  String email;

  UserData(
      {required this.userName, required this.password, required this.email});
}
