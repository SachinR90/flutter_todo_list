
import 'dart:convert';
import 'package:flutter_todo_list/core/constants/constants.dart';
import 'package:flutter_todo_list/core/services/webservice.dart';

class Todo{
  final int userId;
  final int id;
  final String title;
  final bool isCompleted;

  Todo({this.userId, this.id, this.title, this.isCompleted});

  factory Todo.fromJson(Map<String,dynamic> json){
    return Todo(
        userId:json['userId'] as int,
        id:json["id"] as int,
        title: json["title"] as String,
        isCompleted: json["completed"] as bool
    );
  }

  static Data<List<Todo>> all(int startId,int pageLimit){
    var queryParameters = {
      '_start': startId.toString(),
      '_limit': pageLimit.toString(),
    };
    return Data(
      uri: Uri.https(Constants.BASE_URL,Constants.TODO_LIST_URL,queryParameters),
      parse: (response){
        final result = json.decode(response.body);
        Iterable list = result;
        return list.map((model) => Todo.fromJson(model)).toList();
      }
    );
  }
}