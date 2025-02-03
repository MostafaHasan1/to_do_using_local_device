import 'package:flutter/material.dart';
import 'package:to_do/util/dialog_box.dart';
import 'package:to_do/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // text controller
  final _controller = TextEditingController();

  //list of to do task
  List toDoList = [
    ["make tutorial", false],
    ["do exercise", false]
  ];

  //checkbox was tapped

  void checkBoxChanged(bool? value, int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  // save new task
  void saveNewTask(){
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Center(child: Text("ToDo", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(onPressed: creatNewTask, child: Icon(Icons.add), backgroundColor: Colors.yellow,),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoTile(taskName: toDoList[index][0], taskCompleted: toDoList[index][1], onChanged: (value) => checkBoxChanged(value, index));
        },
      ),
    );
  }
}
