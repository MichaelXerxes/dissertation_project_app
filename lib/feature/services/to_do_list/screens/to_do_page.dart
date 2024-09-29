import 'package:dissertation_project_app/core/components/bottom_bar.dart';
import 'package:dissertation_project_app/core/components/filter_menu/filter_menu_to_do_list.dart';
import 'package:dissertation_project_app/core/components/priority_dropdown/priority_dropdown.dart';
import 'package:dissertation_project_app/core/enums/fliter_menu_to_do_list_enum.dart';
import 'package:dissertation_project_app/core/models/to_do_item/to_do_item_model.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/screens/edit_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_item_page.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  FilterMenuToDoListEnum _selectedFilter = FilterMenuToDoListEnum.ALL;

  List<ToDoItem> _filteredToDos(List<ToDoItem> todos) {
    if (_selectedFilter == FilterMenuToDoListEnum.ALL) {
      return todos;
    } else if (_selectedFilter == FilterMenuToDoListEnum.TITLE) {
      return todos..sort((a, b) => a.title.compareTo(b.title));
    } else if (_selectedFilter == FilterMenuToDoListEnum.DATE) {
      return todos..sort((a, b) => a.dateTimeAdded.compareTo(b.dateTimeAdded));
    } else if (_selectedFilter == FilterMenuToDoListEnum.PRIORITY) {
      return todos
        ..sort((a, b) => b.priority.index.compareTo(a.priority.index));
    }
    return todos;
  }

  void _filterShowModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FilterMenuToDoList(
          onFilterSelected: (filter) {
            setState(() {
              _selectedFilter = filter;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: _filterShowModalBottomSheet,
          ),
        ],
      ),
      body: BlocBuilder<ToDoBloc, ToDoState>(
        builder: (context, state) {
          if (state is ToDoInitial) {
            return const Center(child: Text('No to-dos yet.'));
          } else if (state is ToDoLoadSuccess) {
            final todos = _filteredToDos(state.todos);
            if (todos.isEmpty) {
              return const Center(child: Text('No to-dos yet.'));
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditItemPage(todo: todo),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            context.read<ToDoBloc>().add(
                                  RemoveToDoListItem(id: todo.id),
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Failed to load to-dos.'));
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          heroTag: "hero_to_do_page",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddItemPage()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: BottomBar(indexValue: 2),
    );
  }
}
