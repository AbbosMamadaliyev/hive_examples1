import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_examples1/example5/model/inventory_model.dart';

class HomeModel extends ChangeNotifier {
  final String _boxName = 'inventory';

  var _list = <Inventory>[];

  List<Inventory> get list => _list;

  addItem(Inventory inventory) async {
    final box = await Hive.openBox<Inventory>(_boxName);

    box.add(inventory);
    print('added');

    notifyListeners();
  }

  getItem() async {
    final box = await Hive.openBox<Inventory>(_boxName);
    _list = box.values.toList();

    notifyListeners();
  }

  updateItem(int index, Inventory inventory) {
    final box = Hive.box<Inventory>(_boxName);

    box.putAt(index, inventory);
    notifyListeners();
  }

  deleteItem(int index) {
    final box = Hive.box<Inventory>(_boxName);
    box.deleteAt(index);

    getItem();
    notifyListeners();
  }
}
