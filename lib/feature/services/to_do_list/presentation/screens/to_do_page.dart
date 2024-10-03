import 'package:dissertation_project_app/core/helpers/date_format_helper.dart';
import 'package:dissertation_project_app/core/screens/load_app_data_screen.dart';
import 'package:dissertation_project_app/core/widgets/bottom_bar.dart';
import 'package:dissertation_project_app/core/widgets/filter_menu/filter_menu_to_do_list.dart';
import 'package:dissertation_project_app/core/enums/fliter_menu_to_do_list_enum.dart';
import 'package:dissertation_project_app/core/enums/piority_level_enum.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/presentation/widgets/custom_floating_action_button.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/presentation/widgets/to_do_list_item.dart';
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ToDoBloc>(context).add(LoadToDoList());
  }

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
            return const Center(child: Text('Nothing to do yet...'));
          } else if (state is ToDoLoading) {
            return const LoadAppDataScreen();
          } else if (state is ToDoLoadSuccess) {
            final toDoList = _filteredToDos(state.todos);
            if (toDoList.isEmpty) {
              return const Center(child: Text('Nothing to do yet...'));
            }
            BlocProvider.of<ToDoBloc>(context)
                .add(const CheckForExpiredItems());
            return ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                final todo = toDoList[index];

                return ToDoListItem(todo: todo);
              },
            );
          } else if (state is ToDoError) {
            return const Center(
              child: Text('Failed to load ToDo List . Please try again later.'),
            );
          } else {
            return const LoadAppDataScreen();
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: CustomFloatingActionButton(
          icon: Icons.add,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddItemPage()),
            );
          },
          heroTag: "hero_to_do_page",
        ),
      ),
      bottomNavigationBar: const BottomBar(indexValue: 1),
    );
  }
}
