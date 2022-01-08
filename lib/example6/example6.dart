// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, list_remove_unrelated_type

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_examples1/example6/data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Example6 extends StatefulWidget {
  const Example6({Key? key}) : super(key: key);

  @override
  _Example6State createState() => _Example6State();
}

class _Example6State extends State<Example6> {
  late Box<DataModel> dataBox;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataBox = Hive.box('data_box');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive todo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: dataBox.listenable(),
                builder: (context, Box<DataModel> items, _) {
                  List<int> keys = items.keys.cast<int>().toList();
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final int key = keys[index];
                        final DataModel? data = items.get(key);
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          color: Colors.green,
                          child: SizedBox(
                            height: 80,
                            child: GestureDetector(
                              onTap: () {
                                print(
                                    'index: $index, key: $key, box hajmi: ${dataBox.length}, '
                                    'keys: ${dataBox.keys.toList()}');
                              },
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {
                                        dataBox.delete(key);
                                        keys.removeAt(index);

                                        setState(() {});
                                      },
                                      icon: Icons.delete,
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Text(
                                    data!.title,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  subtitle: Text(data.description),
                                  leading: Text(
                                    '${index + 1}',
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              final _editTitleController =
                                                  TextEditingController(
                                                text: data.title,
                                              );
                                              final _editDescriptionController =
                                                  TextEditingController(
                                                text: data.description,
                                              );
                                              return AlertDialog(
                                                title: Text('Edit'),
                                                content: Column(
                                                  children: [
                                                    TextField(
                                                      controller:
                                                          _editTitleController,
                                                    ),
                                                    TextField(
                                                      controller:
                                                          _editDescriptionController,
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          String newTitle =
                                                              _editTitleController
                                                                  .text;
                                                          String newDesc =
                                                              _editDescriptionController
                                                                  .text;

                                                          DataModel data =
                                                              DataModel(
                                                                  title:
                                                                      newTitle,
                                                                  description:
                                                                      newDesc,
                                                                  complete:
                                                                      false);
                                                          dataBox.put(
                                                              key, data);
                                                          setState(() {});
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Edit')),
                                                  ],
                                                ),
                                              );
                                            });
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.edit)),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, index) => Divider(),
                      itemCount: keys.length);
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add'),
                  content: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(hintText: 'title'),
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(hintText: 'description'),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          String title = titleController.text;
                          String description = descriptionController.text;

                          titleController.clear();
                          descriptionController.clear();

                          DataModel datamodel = DataModel(
                              title: title,
                              description: description,
                              complete: false);

                          dataBox.add(datamodel);

                          Navigator.of(context).pop();
                        },
                        child: Text('Add'))
                  ],
                );
              });
        },
      ),
    );
  }
}
