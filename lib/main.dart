import 'package:flutter/material.dart';
import 'card.dart';
import 'fieldTemplate.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Home",
    initialRoute: '/',
    routes: {
      '/': (context) => TodoList(),
      '/form': (context) => Fillup(ModalRoute.of(context).settings.arguments),
    },
  ));
}

//class for creating list of Task

class Work {
  final String title;
  final String subTitle;

  Work({this.title, this.subTitle});
}

List<Work> todoList = [];

///MainPage

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  int taskDone = 0;
  void removeItem(String title) {
    setState(() {
      todoList.removeWhere((item) => item.title == title);
    });
  }

  void taskCompleted(String title) {
    setState(() {
      taskDone++;
      todoList.removeWhere((item) => item.title == title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      drawer: Drawer(
        child: Container(
          color: Colors.yellow[100],
          child: ListView(
            children: <Widget>[
              DrawerHeader(child: Icon(Icons.account_circle, size: 70)),
              ListTile(
                title: Text(
                  "Completed Task :         $taskDone",
                  style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("TodoList"),
      ),
      body: todoList.length == 0
          ? Center(
              child: Text('Add task to TodoList',
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.orange)))
          : (ListView(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Center(
                      child: Text("Today's Task",
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.orange)),
                    )),
                Column(
                  children: todoList.map((currentTask) {
                    return Task(currentTask.title, currentTask.subTitle,
                        onDelete: () => removeItem(currentTask.title),
                        onComplete: () => taskCompleted(currentTask.title));
                  }).toList(),
                ),
              ],
            )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/form', arguments: todoList);
        },
        backgroundColor: Colors.orange,
      ),
    );
  }
}

//// Form for adding task to TodoList

class Fillup extends StatefulWidget {
  final List<Work> arguments;
  Fillup(this.arguments);

  @override
  _FillupState createState() => _FillupState();
}

class _FillupState extends State<Fillup> {
  var titleHandler = TextEditingController();
  var subTitleHandler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[100],
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.calendar_today),
          ),
          title: Text("TodoList"),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Field(titleHandler, "Your task", "Title*"),
                Field(
                    subTitleHandler, "Briefly describe your task", "Sub-title"),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: MaterialButton(
                      color: Colors.orange,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          widget.arguments.add(Work(
                              title: titleHandler.text,
                              subTitle: subTitleHandler.text));
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Add to Todo-List"),
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                )
              ],
            ),
          ),
        ));
  }
}
