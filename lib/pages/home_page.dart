import 'package:flutter/material.dart';
import 'package:flutter_todo_11april24/data/database.dart';
import 'package:flutter_todo_11april24/utalities/DiologueBox.dart';
import 'package:flutter_todo_11april24/utalities/todo_tiles.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box("mybox");
  bool taskstatus = false;
  final _controller = TextEditingController();

  ToDoDataBase db = ToDoDataBase();

  void checkboxchanged(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
    });
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) => DiologueBOx(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
//This will add New Task

  void saveNewTask() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        db.todolist.add([_controller.text, false]);
        Navigator.of(context).pop();
        _controller.clear();
        db.updateDataBase();
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  void deleteTask(int index) {
    setState(() {
      db.todolist.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  void initState() {
    //if this is the first time open the app , then create deafault data

    if (_mybox.get("TODOLIST") == null) {
      db.createinitialData();
    } else {
      // this will load previus data
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.todolist.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoTiles(
            taskName: db.todolist[index][0],
            onChanged: (value) {
              checkboxchanged(taskstatus, index);
            },
            taskcompled: db.todolist[index][1],
            deleteFunction: (value) {
              deleteTask(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          createNewTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
