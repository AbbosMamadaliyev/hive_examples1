import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp12());
}

class MyApp12 extends StatelessWidget {
  const MyApp12({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box box1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createBox();
  }

  void createBox() async {
    box1 = await Hive.openBox('database1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  box1.put('name', 'proto coders point');
                  box1.put('myname', 'Rajat palankar');
                  print('DATA ADDED');
                },
                child: const Text("Add")),
            ElevatedButton(
                onPressed: () async {
                  print(box1.get('myname'));
                  print(box1.get('name'));
                },
                child: const Text("Read")),
            ElevatedButton(
                onPressed: () {
                  box1.put('name', 'RAJAT');
                },
                child: const Text("Update")),
            ElevatedButton(
                onPressed: () {
                  box1.delete('name');
                },
                child: const Text("Delete")),
            ElevatedButton(
                onPressed: () {
                  print(box1.toMap());
                },
                child: const Text("Read All Data")),
            ElevatedButton(
                onPressed: () {
                  Hive.box('database1').clear();
                },
                child: const Text("Delete BOX")),
          ],
        ),
      ),
    );
  }
}
