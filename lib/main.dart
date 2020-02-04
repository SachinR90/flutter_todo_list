import 'package:flutter/material.dart';
import 'package:flutter_todo_list/core/views/home.dart';
import 'package:flutter_todo_list/core/views/home_view_contract.dart';

void main() => runApp(TodoListApp());

class TodoListApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage()
    );
  }
}

class TodoListPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}