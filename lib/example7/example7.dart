// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_examples1/example7/sign_in.dart';
import 'package:hive_examples1/example7/user_data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Example7 extends StatefulWidget {
  const Example7({Key? key}) : super(key: key);

  @override
  _Example7State createState() => _Example7State();
}

class _Example7State extends State<Example7> {
  late Box<UserData> userBox;

  final usernameContr = TextEditingController();
  final emailContr = TextEditingController();
  final passwordContr = TextEditingController();

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
        title: Text('Registration'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: usernameContr,
                decoration: InputDecoration(hintText: 'username'),
              ),
              TextField(
                controller: emailContr,
                decoration: InputDecoration(hintText: 'email'),
              ),
              TextField(
                controller: passwordContr,
                decoration: InputDecoration(hintText: 'password'),
              ),
              SizedBox(height: 100),
              TextButton(
                onPressed: () {
                  _signUp(context);
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp(BuildContext context) {
    String userName = usernameContr.text;
    String email = emailContr.text;
    String password = passwordContr.text;

    UserData data =
        UserData(userName: userName, password: password, email: email);

    if (userName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      userBox.add(data);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SignIn()));

      usernameContr.clear();
      emailContr.clear();
      passwordContr.clear();
    } else {
      final snackBar = SnackBar(
        content: Text('iltmos maydonlarni toldiring!'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
