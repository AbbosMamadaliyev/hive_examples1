// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_examples1/example3/employee.dart';
import 'package:hive_examples1/example3/employee_list_screen.dart';

class AddOrEditEmployeeScreen extends StatefulWidget {
  bool isEdit;
  late int position;
  late Employee employee;

  // ignore: use_key_in_widget_constructors
  AddOrEditEmployeeScreen(this.isEdit, this.position, this.employee);

  AddOrEditEmployeeScreen.isEdit(this.isEdit, {Key? key}) : super(key: key);

  @override
  _AddOrEditEmployeeScreenState createState() =>
      _AddOrEditEmployeeScreenState();
}

class _AddOrEditEmployeeScreenState extends State<AddOrEditEmployeeScreen> {
  final controllerName = TextEditingController();
  final controllerSalary = TextEditingController();
  final controllerAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Employee name',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        controller: controllerName,
                      ),
                    ),
                  ],
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Employee age',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 38,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: controllerAge,
                      ),
                    ),
                  ],
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Employee salary',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        controller: controllerSalary,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () async {
                    var name = controllerName.text;
                    var age = controllerAge.text.toString();
                    var salary = controllerSalary.text.toString();

                    if (name.isNotEmpty &&
                        age.isNotEmpty &&
                        salary.isNotEmpty) {
                      if (widget.isEdit) {
                        Employee updateEmployee = Employee(
                            empName: name, empSalary: salary, empAge: age);

                        var box = await Hive.openBox<Employee>('some_box');
                        box.putAt(widget.position, updateEmployee);
                      } else {
                        Employee addEmployee = Employee(
                            empName: name, empSalary: salary, empAge: age);

                        var box = await Hive.openBox<Employee>('some_box');
                        box.add(addEmployee);
                      }
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployeeList(),
                          ),
                          (route) => false);
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
