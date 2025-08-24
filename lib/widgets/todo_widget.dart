import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_visualization/widgets/counter_widget.dart';
import '../providers/todo_provider.dart';

class TodoWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends ConsumerState<TodoWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoProvider);
    final completedCount = ref.watch(completedTodosProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TODO Demo', style: Theme.of(context).textTheme.titleLarge),
            Text('Completed: $completedCount / ${todos.length}'),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add a todo...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      ref.read(todoProvider.notifier).addTodo(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return CheckboxListTile(
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    value: todo.isCompleted,
                    onChanged: (_) {
                      ref.read(todoProvider.notifier).toggleTodo(todo.id);
                    },
                    secondary: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        ref.read(todoProvider.notifier).removeTodo(todo.id);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
