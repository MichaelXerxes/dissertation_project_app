import 'package:dissertation_project_app/core/components/priority_dropdown/priority_dropdown.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/bloc/to_do_bloc.dart';
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

                return Container(
                  color: PriorityDropdown.getPriorityColor(todo.priority),
                  child: ListTile(
                    title: Text(todo.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Priority: ${todo.priority.toString().split('.').last}'),
                        Text('Content: ${todo.content}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        context.read<ToDoBloc>().add(RemoveToDo(id: todo.id));
                      },
                    ),
                    // style: ListTileStyle.list(),
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
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddItemPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
