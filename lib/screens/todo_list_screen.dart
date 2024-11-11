import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/providers/todo_provider.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: "New Todo",
                  suffixIcon: IconButton(
                    onPressed: () {
                      final newTodo = _textEditingController.text;
                      if (newTodo.isNotEmpty) {
                        context.read<TodoProvider>().addTodo(newTodo);
                        _listKey.currentState?.insertItem(
                          context.read<TodoProvider>().todos.length - 1,
                        );
                        _textEditingController.clear();
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<TodoProvider>(
                builder: (context, todoProvider, child) {
                  return AnimatedList(
                    key: _listKey,
                    initialItemCount: todoProvider.todos.length,
                    itemBuilder: (context, index, animation) {
                      final todo = todoProvider.todos[index];
                      return _buildAnimatedTile(todo.title, index, animation);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedTile(
      String title, int index, Animation<double> animation) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.bounceOut, // 원하는 커브를 설정
    );
    return SizeTransition(
      sizeFactor: curvedAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              _removeItem(index);
            },
          ),
        ),
      ),
    );
  }

  void _removeItem(int index) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    final removedTodo = todoProvider.todos[index];

    _listKey.currentState?.removeItem(
      index,
      (context, animation) =>
          _buildAnimatedTile(removedTodo.title, index, animation),
      duration: const Duration(milliseconds: 1000),
    );

    todoProvider.deleteTodo(index);
  }
}
