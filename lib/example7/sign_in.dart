// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:hive_examples1/example7/show_data.dart';
import 'package:hive_examples1/example7/user_data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late Box<UserData> userBox;

  final _emailContr = TextEditingController();
  final _passwordContr = TextEditingController();

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
        title: Text('Sign in'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ValueListenableBuilder(
            builder: (BuildContext context, value, Widget? child) {
              return Column(
                children: [
                  TextField(
                    controller: _emailContr,
                    decoration: InputDecoration(hintText: 'email'),
                  ),
                  TextField(
                    controller: _passwordContr,
                    decoration: InputDecoration(hintText: 'password'),
                  ),
                  SizedBox(height: 100),
                  TextButton(
                    onPressed: () {
                      bool isLogin = false;

                      _auth(context);
                    },
                    child: Text('Sign In'),
                  ),
                ],
              );
            },
            valueListenable: userBox.listenable(),
          ),
        ),
      ),
    );
  }

  void _auth(BuildContext context) {
    String email = _emailContr.text;
    String password = _passwordContr.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      for (var value in userBox.values.map((e) => e.email)) {
        if (email == value) {
          for (var pass in userBox.values.map((e) => e.password)) {
            if (password == pass) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ShowUsersData()));
              _emailContr.clear();
              _passwordContr.clear();
            }
          }
        }
      }
    } else {
      final snackBar = SnackBar(
        content: Text('iltmos maydonlarni toldiring!'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
