import 'package:dissertation_project_app/core/models/to_do_item/to_do_item_model.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddItemPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ToDo Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Enter to-do title:'),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'To-Do Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a to-do title.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final todo = ToDoItem(
                      id: uuid.v4(),
                      title: _titleController.text,
                    );
                    context.read<ToDoBloc>().add(AddToDo(todo: todo));
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
