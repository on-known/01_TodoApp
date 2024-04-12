// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_todo_11april24/utalities/DiologueBox.dart';
import 'package:flutter_todo_11april24/utalities/todo_tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool taskstatus = false;
  final _controller = TextEditingController();

  List todolist = [];

  void checkboxchanged(bool? value, int index) {
    setState(() {
      todolist[index][1] = !todolist[index][1];
    });
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
      todolist.add([_controller.text, false]);
      Navigator.of(context).pop();
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: todolist.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoTiles(
            taskName: todolist[index][0],
            onChanged: (value) {
              checkboxchanged(taskstatus, index);
            },
            taskcompled: todolist[index][1],
            deleteFunction: (value) {
              setState(() {
                todolist.removeAt(index);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
