// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_examples1/example3/edit_or_add.dart';

import 'employee.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<Employee> employeeList = [];

  void getEmployees() async {
    final box = await Hive.openBox<Employee>('some_box');
    setState(() {
      employeeList = box.values.toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getEmployees();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hive simple'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddOrEditEmployeeScreen.isEdit(false);
              }));
            },
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: employeeList.length,
            itemBuilder: (context, position) {
              Employee _getEmployee = employeeList[position];
              var salary = _getEmployee.empSalary;
              var age = _getEmployee.empAge;
              var name = _getEmployee.empName;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                  child: Container(
                    padding: const EdgeInsets.all(14.0),
                    height: 80,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          // child: Text('data'),
                          child: Text(
                            'Salary: $salary | Age: $age',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 45.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              color: Colors.green,
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return AddOrEditEmployeeScreen(
                                      true, position, _getEmployee);
                                }));
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.delete_forever),
                            onPressed: () {
                              final box = Hive.box<Employee>('some_box');
                              box.deleteAt(position);
                              setState(() {
                                employeeList.removeAt(position);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
