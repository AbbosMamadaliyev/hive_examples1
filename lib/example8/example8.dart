// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_examples1/example8/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Example8 extends StatefulWidget {
  const Example8({Key? key}) : super(key: key);

  @override
  _Example8State createState() => _Example8State();
}

class _Example8State extends State<Example8> {
  late Box<Todo> todoBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoBox = Hive.box<Todo>('todo_box');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: ValueListenableBuilder(
        builder: (BuildContext context, Box<Todo> value, Widget? child) {
          if (value.values.isEmpty) {
            return Center(
              child: Text('Todo list is empty'),
            );
          } else {
            return ListView.builder(
                itemCount: value.values.length,
                itemBuilder: (context, index) {
                  Todo? todo = value.getAt(index);
                  return ListTile(
                    title: Text(todo!.task),
                    subtitle: Text(todo.note),
                  );
                });
          }
        },
        valueListenable: todoBox.listenable(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onFormSubmit();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onFormSubmit(){

}

}
