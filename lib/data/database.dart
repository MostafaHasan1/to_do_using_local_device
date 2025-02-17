import 'package:hive_ce_flutter/hive_flutter.dart';

class ToDoDataBase{

  // emtry list
  List toDoList = [];

  //reference our box
  final _myBox = Hive.box('mybox');

  void createInitialData(){
    //if it is the first time opening the app
    toDoList = [
      ['Make tutorial', false],
      ['Do exercise', false]
    ];
  }

  void loadData(){
    // load the data while started
    toDoList = _myBox.get('TODOLIST');
  }

  void updateDataBase(){
    //update the database if any changes make
    _myBox.put("TODOLIST", toDoList);
  }
}