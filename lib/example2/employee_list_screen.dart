// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_examples1/example2/employee.dart';

import 'edit_or_add.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<Employee> listEmployees = [];

  void getEmployees() async {
    final box = await Hive.openBox<Employee>('employee');
    setState(() {
      listEmployees = box.values.toList();
    });
  }

  @override
  void initState() {
    getEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Hive Sample"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddOrEditEmployeeScreen.isEdit(false),
                  ),
                );
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: listEmployees.length,
            itemBuilder: (context, position) {
              Employee employee = listEmployees[position];
              var salary = employee.empSalary;
              var age = employee.empAge;
              return Card(
                elevation: 8,
                child: Container(
                  height: 80,
                  padding: EdgeInsets.all(15),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          employee.empName,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 45),
                          child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AddOrEditEmployeeScreen(
                                        true, position, employee),
                                  ),
                                );
                              }),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              final box = Hive.box<Employee>('employee');
                              box.deleteAt(position);
                              setState(
                                  () => {listEmployees.removeAt(position)});
                            }),
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Salary: $salary | Age: $age",
                              style: TextStyle(fontSize: 18))),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
