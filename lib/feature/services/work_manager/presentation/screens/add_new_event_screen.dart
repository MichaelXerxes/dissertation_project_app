import 'package:dissertation_project_app/feature/services/work_manager/bloc/work_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class AddNewEventScreen extends StatefulWidget {
  const AddNewEventScreen({super.key});

  @override
  _AddNewEventScreenState createState() => _AddNewEventScreenState();
}

class _AddNewEventScreenState extends State<AddNewEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllerName = TextEditingController();
  final _controllerDescription = TextEditingController();
  DateTime? _fromSelectedDate;
  DateTime? _toSelectedDate;
  TimeOfDay? _fromSelectedTime;
  TimeOfDay? _toSelectedTime;
  bool _isAllDay = false;

  Future<void> _selectFromDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _fromSelectedDate = pickedDate;
          _fromSelectedTime = pickedTime;
        });
      }
    }
  }

  Future<void> _selectToDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _toSelectedDate = pickedDate;
          _toSelectedTime = pickedTime;
        });
      }
    }
  }

  DateTime _combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  void _addMeeting() {
    if (_formKey.currentState!.validate()) {
      final eventName = _controllerName.text;
      final eventDescription = _controllerDescription.text;
      final from = _combineDateAndTime(
          _fromSelectedDate ?? DateTime.now(), _fromSelectedTime ?? TimeOfDay.now());
      final to = _combineDateAndTime(
          _toSelectedDate ?? from, _toSelectedTime ?? TimeOfDay(hour: from.hour + 1, minute: 0));

      BlocProvider.of<WorkManagerBloc>(context).add(AddMeetingEvent(
        eventName: eventName,
        eventDescription: eventDescription,
        from: from,
        to: to,
        isAllDay: _isAllDay,
      ));

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _controllerName,
                decoration: const InputDecoration(
                  labelText: 'Event Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerDescription,
                decoration: const InputDecoration(
                  labelText: 'Event Description',
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('From'),
                subtitle: Text(_fromSelectedDate != null && _fromSelectedTime != null
                    ? '${_fromSelectedDate!.toLocal().toString().split(' ')[0]} ${_fromSelectedTime!.format(context)}'
                    : 'Select Start Date & Time'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectFromDateTime(context),
                ),
              ),
              ListTile(
                title: const Text('To'),
                subtitle: Text(_toSelectedDate != null && _toSelectedTime != null
                    ? '${_toSelectedDate!.toLocal().toString().split(' ')[0]} ${_toSelectedTime!.format(context)}'
                    : 'Select End Date & Time'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectToDateTime(context),
                ),
              ),
              SwitchListTile(
                title: const Text('All Day Event'),
                value: _isAllDay,
                onChanged: (bool value) {
                  setState(() {
                    _isAllDay = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              FloatingActionButton(
                onPressed: _addMeeting,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
