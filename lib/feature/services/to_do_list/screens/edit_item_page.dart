import 'package:dissertation_project_app/core/components/priority_dropdown/priority_dropdown.dart';
import 'package:dissertation_project_app/core/enums/piority_level.dart';
import 'package:dissertation_project_app/core/models/to_do_item/to_do_item_model.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditItemPage extends StatefulWidget {
  final ToDoItem todo;

  const EditItemPage({Key? key, required this.todo}) : super(key: key);

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late PriorityLevel _selectedPriority;

  @override
  void initState() {
    super.initState();
    // Initialize controllers and values with the existing todo data
    _titleController = TextEditingController(text: widget.todo.title);
    _contentController = TextEditingController(text: widget.todo.content);
    _selectedPriority = widget.todo.priority;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ToDo Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Edit Event'),
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
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: 'Content...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              PriorityDropdown(
                selectedPriority: _selectedPriority,
                onChanged: (PriorityLevel newPriority) {
                  setState(() {
                    _selectedPriority = newPriority;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedToDo = ToDoItem(
                      id: widget.todo.id, // Keep the same ID
                      title: _titleController.text,
                      content: _contentController.text,
                      priority: _selectedPriority,
                    );
                    // Dispatch an update event instead of an add event
                    context.read<ToDoBloc>().add(UpdateToDo(todo: updatedToDo));
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
