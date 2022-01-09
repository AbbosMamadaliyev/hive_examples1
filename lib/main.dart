import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_examples1/example7/user_data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/my_app.dart';

/*void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(PersonAdapter());


  await Hive.openBox('user_box');
  runApp(const MyApp());
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.deleteBoxFromDisk('inventory_box');
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(4)) {
    Hive.registerAdapter(UserDataAdapter());
  }
  await Hive.openBox<UserData>('user_data');

  runApp(const MyApp());
}
