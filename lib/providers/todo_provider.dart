import 'package:flutter/material.dart';
import 'package:provider_app/models/todo.dart';

class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  void addTodo(String title) {
    _todos.add(Todo(title: title));
    notifyListeners();
  }

  void toggleTodoComplete(int index) {
    _todos[index].isComplete = !_todos[index].isComplete;
    notifyListeners();
  }

  void deleteTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
