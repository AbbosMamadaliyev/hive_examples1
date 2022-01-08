// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'add_screen.dart';
import 'update_screen.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late final Box contactBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactBox = Hive.box('people_box');
  }

  @override
  void dispose() {
    // TODO: implement dispose

    Hive.close();
    super.dispose();
  }

  // _addInfo() async {
  //   // Add info to people box
  //   box.put('name', 'John');
  //   box.put('country', 'Italy');
  //   print('info added');
  // }
  //
  // _getInfo() {
  //   // Get info from people box
  //   var name = box.get('name');
  //   var country = box.get('country');
  //   print('Info retrieved from box: $name ($country)');
  // }
  //
  // _updateInfo() {
  //   // Update info of people box
  //   box.put('name', 'Mike');
  //   box.put('country', 'United States');
  //   print('Info updated in box!');
  // }

  _deleteInfo(int index) {
    // Delete info from people box
    contactBox.deleteAt(index);
    print('item deleted from box at index: $index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People info'),
      ),
      body: ValueListenableBuilder(
        valueListenable: contactBox.listenable(),
        builder: (BuildContext context, Box box, Widget? child) {
          if (box.isEmpty) {
            return Center(
              child: Text('Empty'),
            );
          } else {
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  var currentBox = box;
                  var personData = currentBox.getAt(index);
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UpdateScreen(
                          index: index,
                          person: personData,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Text(personData.name),
                      subtitle: Text(personData.country),
                      trailing: IconButton(
                        onPressed: () => _deleteInfo(index),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddScreen(),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
