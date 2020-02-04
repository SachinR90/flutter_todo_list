import 'package:flutter_todo_list/core/models/todo.dart';
import 'package:flutter_todo_list/core/presenters/home_presenter_contract.dart';
import 'package:flutter_todo_list/core/services/webservice.dart';
import 'package:flutter_todo_list/core/views/home_view_contract.dart';

class HomePresenter implements HomePresenterContract {
  HomeViewContract _homeView;
  Webservice webservice;
  List<Todo> _listOfTodos = [];
  HomePresenter(this._homeView);

  @override
  void fetchTodo(int startId, int pageLimit) {
    Webservice().load(Todo.all(startId, pageLimit)).then((todos) {
      if (todos.isNotEmpty) {
        _listOfTodos.addAll(todos);
        _homeView.onTodoFetchCompleted(_listOfTodos);
      } else {
        _homeView.onTodoFetchFailed('No more content');
      }
    }).catchError((onError) {
      print(onError);
      _homeView.onTodoFetchFailed(onError.toString());
    });
  }
}
