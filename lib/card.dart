import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  final String _title;
  final String _subtitle;
  final VoidCallback onDelete;
  final VoidCallback onComplete;

  Task(this._title, this._subtitle, {this.onDelete, this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          color: Colors.yellow[50],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.work),
                title: Text(_title),
                subtitle: Text(_subtitle),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text("Completed",
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontFamily: "Roboto",
                            fontSize: 15)),
                    onPressed: () {
                      onComplete();
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      onDelete();
                    },
                    child: Text("Remove",
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: "Roboto",
                            fontSize: 15)),
                  )
                ],
              )
            ],
          )),
    );
  }
}
