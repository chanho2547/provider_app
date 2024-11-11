// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:provider_app/models/todo.dart';

class TodoItem extends StatelessWidget {
  int index;
  Todo todo;

  TodoItem({
    super.key,
    required this.index,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: IconButton(
        onPressed: () {
          // context.read();
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
