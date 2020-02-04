import 'package:flutter/material.dart';
import 'package:flutter_todo_list/core/models/todo.dart';

class TodoListItem extends ListTile {
  TodoListItem(Todo todo)
      : super(
            title: Row(
                children: <Widget>[
              Text('ID:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Text(todo.id.toString(), style: TextStyle(color: Colors.red))
            ]),
            subtitle: Text(todo.title),
            trailing: (todo.isCompleted
                ? Icon(Icons.check, color: Colors.green)
                : Icon(Icons.alarm, color: Colors.orange)
            )
  );
}
