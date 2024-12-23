import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/utils/appbar_widget.dart';

import '../data/database.dart';
import '../utils/dialog_box.dart';
import '../utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  //When the app runs
  @override
  void initState() {
    // If the app is first time opened
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //there is already some data
      db.loadData();
    }
    super.initState();
  }

  //Text Controller
  final _controller = TextEditingController();

  //CheckBox was tapped

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  //Save new Task
  void saveNewTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        db.toDoList.add([_controller.text, false]);
      });
      _controller.clear(); // Clear the text field after saving the task
      Navigator.of(context).pop();
      db.updateDatabase();
    }
  }

  //Create new Task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  //Delete Task

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppbarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        elevation: 10,
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (p0) => deleteTask(index),
          );
        },
      ),
    );
  }
}
