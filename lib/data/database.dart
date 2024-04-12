import 'package:hive/hive.dart';

class ToDoDataBase {
  List todolist = [];

//referebce the box
  final _mybox = Hive.box("mybox");

  // run this method if this is the 1st time ever opening this app

  void createinitialData() {
    todolist = [
      ["Meditation", false],
      ["Prayer", false]
    ];
  }

  //load the data from the data base

  void loadData() {
    todolist = _mybox.get("TODOLIST");
  }

  //update the database

  void updateDataBase() {
    _mybox.put("TODOLIST", todolist);
  }
}
