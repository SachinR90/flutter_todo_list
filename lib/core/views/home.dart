import 'package:flutter/material.dart';
import 'package:flutter_todo_list/core/models/todo.dart';
import 'package:flutter_todo_list/core/presenters/home_presenter.dart';
import 'package:flutter_todo_list/core/presenters/home_presenter_contract.dart';
import 'package:flutter_todo_list/core/views/todo_list_item.dart';
import 'home_view_contract.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> implements HomeViewContract {
  HomePresenterContract _presenter;
  List<Todo> _todoList;
  final int _limit = 50;
  int _startId = 0;
  bool _isLoading = false;

  _HomeState() {
    _todoList = [];
    _presenter = HomePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.fetchTodo(_startId, _limit);
  }

  @override
  void onTodoFetchCompleted(List<Todo> items) {
    setState(() {
      _todoList = items;
      _isLoading = false;
    });
  }

  @override
  void onTodoFetchFailed(String message) {
    _showDialog(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Todo List"),
          ),
        ),
        body: getBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (!_isLoading) {
              _startId = _todoList.last.id;
              _presenter.fetchTodo(_startId, _limit);
              setState(() {
                _isLoading = true;
              });
            }
          },
          child: Icon(Icons.add, color: Colors.white),
        ));
  }

  Widget getBody() {
    var widget;
    widget = Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: _buildTodoList(),
            )),
        Visibility(
          visible: _isLoading, //Default is true,
          child: Align(
              alignment: Alignment.center,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CircularProgressIndicator(),
                ),
              )),
        )
      ],
    );
    return widget;
  }

  List<TodoListItem> _buildTodoList() {
    return _todoList.map((todo) => TodoListItem(todo)).toList();
  }

  void _showDialog(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ],
        );
      },
    );
  }
}
