import 'package:flutter/material.dart';
import 'package:hive_examples1/example0/person.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UpdateScreen extends StatefulWidget {
  final int index;
  final Person person;
  const UpdateScreen({Key? key, required this.index, required this.person})
      : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('update info'),
      ),
      body: UpdatePersonForm(
        index: widget.index,
        person: widget.person,
      ),
    );
  }
}

class UpdatePersonForm extends StatefulWidget {
  final int index;
  final Person person;
  const UpdatePersonForm({Key? key, required this.index, required this.person})
      : super(key: key);

  @override
  _UpdatePersonFormState createState() => _UpdatePersonFormState();
}

class _UpdatePersonFormState extends State<UpdatePersonForm> {
  late final _nameController;
  late final _countryController;
  late final Box box;

  final _personFormKey = GlobalKey<FormState>();

  _updateInfo() {
    Person person =
        Person(name: _nameController.text, country: _countryController.text);

    box.put(widget.index, person);
    print('Info updated in box!');
  }

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can not empty';
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    box = Hive.box('people_box');

    _nameController = TextEditingController(text: widget.person.name);
    _countryController = TextEditingController(text: widget.person.country);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _personFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name'),
            TextFormField(
              controller: _nameController,
              validator: _fieldValidator,
            ),
            SizedBox(height: 24.0),
            Text('Home Country'),
            TextFormField(
              controller: _countryController,
              validator: _fieldValidator,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
              child: Container(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_personFormKey.currentState!.validate()) {
                      _updateInfo();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Add'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
