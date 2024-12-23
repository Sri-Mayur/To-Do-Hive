import 'package:hive/hive.dart';

class ToDoDatabase {
  List toDoList = [];

  //reference our box
  final _myBox = Hive.box('mybox');

  // Run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Study!👩🏻‍💻", false],
      ["Work Out🏋", false],
      ["Rest Properly 😴", false],
    ];
  }

  //Load the data from the database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //Update the database
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
