import 'package:dissertation_project_app/core/widgets/bottom_bar.dart';
import 'package:dissertation_project_app/core/widgets/filter_menu/filter_menu_to_do_list.dart';
import 'package:dissertation_project_app/core/widgets/priority_dropdown/priority_dropdown.dart';
import 'package:dissertation_project_app/core/enums/fliter_menu_to_do_list_enum.dart';
import 'package:dissertation_project_app/core/enums/piority_level_enum.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
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

  List<ToDoItem> _filteredToDos(List<ToDoItem> toDoList) {
    switch (_selectedFilter) {
      case FilterMenuToDoListEnum.TITLE:
        return toDoList..sort((a, b) => a.title.compareTo(b.title));
      case FilterMenuToDoListEnum.DATE:
        return toDoList
          ..sort((a, b) => a.dateTimeAdded.compareTo(b.dateTimeAdded));
      case FilterMenuToDoListEnum.PRIORITY:
        return toDoList
          ..sort((a, b) => b.priority.index.compareTo(a.priority.index));
      case FilterMenuToDoListEnum.HIGH:
        return toDoList
            .where((todo) => todo.priority == PriorityLevelEnum.HIGH)
            .toList();
      case FilterMenuToDoListEnum.MEDIUM:
        return toDoList
            .where((todo) => todo.priority == PriorityLevelEnum.MEDIUM)
            .toList();
      case FilterMenuToDoListEnum.LOW:
        return toDoList
            .where((todo) => todo.priority == PriorityLevelEnum.LOW)
            .toList();
      default:
        return toDoList;
    }
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
        title: Text('To-Do Service '),
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
