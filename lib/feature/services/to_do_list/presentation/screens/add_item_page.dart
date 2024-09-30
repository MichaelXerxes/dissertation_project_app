import 'package:dissertation_project_app/core/helpers/constants.dart';
import 'package:dissertation_project_app/core/widgets/priority_dropdown/priority_dropdown.dart';
import 'package:dissertation_project_app/core/enums/piority_level_enum.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/presentation/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddItemPage extends StatefulWidget {
  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _globalKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final uuid = const Uuid();
  DateTime? _expiredDateSelected;

  PriorityLevelEnum _prioritySelected = PriorityLevelEnum.MEDIUM;

  Future<void> _datePicker(BuildContext context) async {
    final DateTime? calendarPicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2099),
    );
    if (calendarPicker != null && calendarPicker != _expiredDateSelected) {
      setState(() {
        _expiredDateSelected = calendarPicker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ToDo Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              Text('New Event'),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Enter title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a to-do title.';
                  }
                  return null;
                },
                maxLength: Constants.MAX_LENGHT_TEXT_TITLE,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: 'Content...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a to-do title.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              PriorityDropdown(
                selectedPriority: _prioritySelected,
                onChanged: (PriorityLevelEnum newPriority) {
                  setState(() {
                    _prioritySelected = newPriority;
                  });
                },
              ),
              SizedBox(height: 20),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Text(
              //         _expiredDateSelected == null
              //             ? 'Select Expiration Date'
              //             : 'Expires: ${_expiredDateSelected!.toLocal()}'
              //                 .split(' ')[0],
              //       ),
              //     ),
              //     IconButton(
              //       icon: const Icon(Icons.calendar_today),
              //       onPressed: () => _datePicker(context),
              //     ),
              //   ],
              // ),
              DatePicker(
                selectedDate: _expiredDateSelected,
                onDateSelected: (DateTime? selectedDate) {
                  setState(() {
                    _expiredDateSelected = selectedDate;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_globalKey.currentState!.validate()) {
                    final todo = ToDoItem(
                      id: uuid.v4(),
                      title: _titleController.text,
                      content: _contentController.text,
                      priority: _prioritySelected,
                      expiredDate: _expiredDateSelected,
                    );
                    context.read<ToDoBloc>().add(AddToDoListItem(todo: todo));
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Add ToDo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
