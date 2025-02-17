import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:to_do/data/database.dart';
import 'package:to_do/util/dialog_box.dart';
import 'package:to_do/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // reference the hive box
  final _myBox = Hive.box('mybox');

  // initializing our toDoList database class
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {

    // if this is the first time ever opening app
    if(_myBox.get('TODOLIST')== null){
      db.createInitialData();
    }else{
      //already exist data
      db.loadData();
    }

    // TODO: implement initState
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  //checkbox was tapped

  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
db.updateDataBase();
  }

  void creatNewTask(){
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
        },
    );
    db.updateDataBase();
  }

  // delete task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Center(child: Text("ToDo", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(onPressed: creatNewTask, backgroundColor: Colors.yellow, child: const Icon(Icons.add),),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
