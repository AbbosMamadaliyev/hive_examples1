// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Example1 extends StatefulWidget {
  const Example1({Key? key}) : super(key: key);

  @override
  _Example1State createState() => _Example1State();
}

class _Example1State extends State<Example1> {
  final _addUserController = TextEditingController();
  late final _editUserController;

  late final Box contactBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactBox = Hive.box('user_box');
    // _editUserController = TextEditingController(text: contactBox.getAt(index));
  }

  @override
  void dispose() {
    // TODO: implement dispose

    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD operation in HiveDb'),
        actions: [
          IconButton(
            onPressed: _addUsers,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ValueListenableBuilder(
          valueListenable: contactBox.listenable(),
          builder: (BuildContext context, Box box, Widget? child) {
            if (box.isEmpty) {
              return Center(
                child: Text('Empty'),
              );
            } else {
              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (BuildContext context, int index) {
                  var currentBox = box;
                  // var personData = currentBox.getAt(index);

                  var personData = currentBox.getAt(index);

                  _editUserController =
                      TextEditingController(text: contactBox.getAt(index));

                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () => _showDialog(index),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 3),
                        ),
                        height: 40,
                        child: Text(
                          personData,
                          // 'ggg',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  _addUsers() async {
    contactBox.put('user1', 'Akrom1');
    contactBox.put('user2', 'Akrom2');
    contactBox.put('user3', 'Akrom3');
    print('added');
  }

  void _showDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit user'),
            content: TextField(
              controller: TextEditingController(text: contactBox.getAt(index)),
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text('edit'),
              ),
            ],
          );
        });
  }

  void _showAddUserDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add user'),
            content: TextField(),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text('add'),
              ),
            ],
          );
        });
  }
}
