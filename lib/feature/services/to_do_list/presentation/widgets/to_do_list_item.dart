import 'package:dissertation_project_app/core/helpers/date_format_helper.dart';
import 'package:dissertation_project_app/core/widgets/priority_dropdown/priority_dropdown.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/presentation/screens/edit_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoListItem extends StatelessWidget {
  final ToDoItem todo;
  const ToDoListItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: PriorityDropdown.getPriorityColor(todo.priority),
                width: 3,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                todo.title,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Priority: ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: todo.priority.toString().split('.').last,
                      style: TextStyle(
                        color: PriorityDropdown.getPriorityColor(todo.priority),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Content: ${todo.content}',
                      style: const TextStyle(color: Colors.black54),
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                        'Expired on: ${DateFormatHelper.dateFomrat(todo.expiredDate)}')
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
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
                ],
              ),
            ],
          ),
        ),
        // trailing:
      ),
    );
  }
}
