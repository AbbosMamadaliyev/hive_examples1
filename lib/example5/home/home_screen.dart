// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_examples1/example5/home/home_model.dart';
import 'package:hive_examples1/example5/model/inventory_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late Box<Inventory> dataBox;
  var dataBoxName = 'inventory_box';

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  // var name = '';
  //
  // var description = '';
  // late Inventory inventory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dataBox = Hive.box<Inventory>(dataBoxName);
    //
    // name = nameController.text;
    // description = nameController.text;
    //
    // inventory = Inventory(name: name, description: description);
  }

  @override
  Widget build(BuildContext context) {
    HomeModel model = HomeModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('example hive'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Add inventories'),
                      content: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(hintText: 'name'),
                            controller: nameController,
                          ),
                          TextField(
                            decoration:
                                InputDecoration(hintText: 'description'),
                            controller: descriptionController,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            var name = nameController.text;
                            var description = descriptionController.text;

                            nameController.clear();
                            descriptionController.clear();

                            Inventory inventory =
                                Inventory(name: name, description: description);
                            dataBox.add(inventory);

                            // final box =
                            //     await Hive.openBox<Inventory>('inventory');
                            // box.add(inventory);
                            // = Hive.box('inventory');
                            // model.addItem(inventory);
                            Navigator.of(context).pop();
                            print('list length: ${model.list.length}');
                          },
                          child: Text('Add'),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ValueListenableBuilder(
          valueListenable: dataBox.listenable(),
          builder: (context, Box<Inventory> box, _) {
            List<int> keys = box.keys.cast<int>().toList();
            return ListView.builder(
                // itemCount: model.list.length,
                itemCount: keys.length,
                itemBuilder: (context, index) {
                  final int key = keys[index];
                  final Inventory? inventory = box.get(key);

                  return Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // model.list[index].name,
                                inventory!.name,
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 16),
                              Text(
                                // model.list[index].description,
                                inventory.description,
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Edit inventories'),
                                          content: Column(
                                            children: [
                                              TextField(
                                                decoration: InputDecoration(
                                                    hintText: 'name'),
                                                controller: nameController,
                                              ),
                                              TextField(
                                                decoration: InputDecoration(
                                                    hintText: 'description'),
                                                controller:
                                                    descriptionController,
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                var name = nameController.text;
                                                var description =
                                                    descriptionController.text;

                                                nameController.clear();
                                                descriptionController.clear();

                                                Inventory inventory = Inventory(
                                                    name: name,
                                                    description: description);
                                                dataBox.putAt(index, inventory);

                                                // final box =
                                                //     await Hive.openBox<Inventory>('inventory');
                                                // box.add(inventory);
                                                // = Hive.box('inventory');
                                                // model.addItem(inventory);
                                                Navigator.of(context).pop();
                                                print(
                                                    'list length: ${model.list.length}');
                                              },
                                              child: Text('Add'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                              ),
                              SizedBox(width: 16),
                              IconButton(
                                icon: Icon(Icons.delete_forever),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
