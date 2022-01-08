// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_examples1/example7/user_data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShowUsersData extends StatefulWidget {
  const ShowUsersData({Key? key}) : super(key: key);

  @override
  _ShowUsersDataState createState() => _ShowUsersDataState();
}

class _ShowUsersDataState extends State<ShowUsersData> {
  late Box<UserData> userBox;

  final styleT = TextStyle(fontSize: 18);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBox = Hive.box('user_data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('users data'),
      ),
      body: ValueListenableBuilder(
        valueListenable: userBox.listenable(),
        builder: (BuildContext context, Box<UserData> value, Widget? child) {
          List<int> keys = value.keys.cast<int>().toList();

          return ListView.builder(
              itemCount: value.length,
              itemBuilder: (BuildContext context, int index) {
                final int key = keys[index];
                UserData? data = value.get(key);

                return Card(
                  margin:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
                  color: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'user: ${data!.userName}',
                          style: styleT,
                        ),
                        Text(
                          'email: ${data.email}',
                          style: styleT,
                        ),
                        Text(
                          'password: ${data.password}',
                          style: styleT,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                final _userContr =
                                    TextEditingController(text: data.userName);
                                final _emailContr =
                                    TextEditingController(text: data.email);
                                final _passContr =
                                    TextEditingController(text: data.password);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Edit user info'),
                                        content: Column(
                                          children: [
                                            TextField(
                                              controller: _userContr,
                                            ),
                                            TextField(
                                              controller: _emailContr,
                                            ),
                                            TextField(
                                              controller: _passContr,
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  String userName =
                                                      _userContr.text;
                                                  String email =
                                                      _emailContr.text;
                                                  String password =
                                                      _passContr.text;

                                                  UserData data = UserData(
                                                      userName: userName,
                                                      password: password,
                                                      email: email);
                                                  userBox.put(key, data);
                                                  setState(() {});
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Edit')),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                userBox.delete(key);
                                setState(() {});
                              },
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
    );
  }
}
