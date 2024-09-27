import 'package:dissertation_project_app/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_item_page.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: BlocBuilder<ToDoBloc, ToDoState>(
        builder: (context, state) {
          if (state is ToDoInitial) {
            return Center(child: Text('No to-dos yet.'));
          } else if (state is ToDoLoadSuccess) {
            final todos = state.todos;

            if (todos.isEmpty) {
              return Center(child: Text('No to-dos yet.'));
            }

            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return ListTile(
                  title: Text(todo.title),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      context.read<ToDoBloc>().add(RemoveToDo(id: todo.id));
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Failed to load to-dos.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddItemPage
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddItemPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
