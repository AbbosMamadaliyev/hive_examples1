import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_examples1/example8/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/my_app.dart';

/*void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(PersonAdapter());


  await Hive.openBox('user_box');
  runApp(const MyApp());
}*/

Future<void> main() async {
  // await Hive.deleteBoxFromDisk('inventory_box');
  await Hive.initFlutter();
  // if (!Hive.isAdapterRegistered(2)) {
  Hive.registerAdapter(TodoAdapter());
  // }
  await Hive.openBox<Todo>('todo_box');

  runApp(const MyApp());
}
