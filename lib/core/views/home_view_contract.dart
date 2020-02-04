
import 'package:flutter_todo_list/core/models/todo.dart';

abstract class HomeViewContract{
  ///called when the fetch has been successful
  void onTodoFetchCompleted(List<Todo> items);

  void onTodoFetchFailed(String message);
}