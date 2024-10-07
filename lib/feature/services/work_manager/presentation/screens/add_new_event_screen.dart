import 'package:dissertation_project_app/core/tools/constants.dart';
import 'package:dissertation_project_app/feature/services/work_manager/bloc/work_manager_bloc.dart';
import 'package:dissertation_project_app/feature/services/work_manager/presentation/widgets/color_selector.dart';
import 'package:dissertation_project_app/feature/services/work_manager/presentation/widgets/custom_dropdown_hours.dart';
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
  Color _selectedColor = Colors.red;
  int _eventDurationPerDay = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    if (arguments != null && arguments['selectedDate'] != null) {
      DateTime selectedDate = arguments['selectedDate'];
      _fromSelectedDate = selectedDate;
      _fromSelectedTime = TimeOfDay.fromDateTime(selectedDate);

      // DateTime toDateTime =
      //     selectedDate.add(Duration(hours: _eventDurationPerDay));
      // _toSelectedDate = toDateTime;
      // _toSelectedTime = TimeOfDay.fromDateTime(toDateTime);
    }
  }

  void _onColorSelected(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

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
          // DateTime fromDateTime = _combineDateAndTime(pickedDate, pickedTime);
          // DateTime toDateTime =
          // fromDateTime.add(Duration(hours: _eventDurationPerDay));
          // _toSelectedDate = toDateTime;
          // _toSelectedTime = TimeOfDay.fromDateTime(toDateTime);
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
    if (pickedDate != null && mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null && mounted) {
        setState(() {
          _toSelectedDate = pickedDate;
          _toSelectedTime = pickedTime;

          DateTime fromDateTime = _combineDateAndTime(pickedDate, pickedTime);
          DateTime toDateTime =
              fromDateTime.add(Duration(hours: _eventDurationPerDay));
          _toSelectedDate = toDateTime;
          _toSelectedTime = TimeOfDay.fromDateTime(toDateTime);
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
      final from = _combineDateAndTime(_fromSelectedDate ?? DateTime.now(),
          _fromSelectedTime ?? TimeOfDay.now());
      final to = _combineDateAndTime(_toSelectedDate ?? from,
          _toSelectedTime ?? TimeOfDay(hour: from.hour + _eventDurationPerDay, minute: 0));

      BlocProvider.of<WorkManagerBloc>(context).add(AddMeetingEvent(
        eventName: eventName,
        eventDescription: eventDescription,
        startDate: from,
        finishDate: to,
        background: _selectedColor.withOpacity(0.4),
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
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,  // Add this line
              physics:const NeverScrollableScrollPhysics(),
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
                  maxLength: Constants.MAX_LENGHT_TEXT_TITLE,
                ),
                TextFormField(
                  controller: _controllerDescription,
                  decoration: const InputDecoration(
                    labelText: 'Event Description',
                  ),
                  maxLength: Constants.MAX_LENGHT_TEXT_CONTENT,
                  maxLines: null,
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('From'),
                  subtitle: Text(_fromSelectedDate != null &&
                          _fromSelectedTime != null
                      ? '${_fromSelectedDate!.toLocal().toString().split(' ')[0]} ${_fromSelectedTime!.format(context)}'
                      : 'Select Start Date & Time'),
                  trailing: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectFromDateTime(context),
                  ),
                ),
                ListTile(
                  title: const Text('To'),
                  subtitle: Text(_toSelectedDate != null &&
                          _toSelectedTime != null
                      ? '${_toSelectedDate!.toLocal().toString().split(' ')[0]} ${_toSelectedTime!.format(context)}'
                      : 'Select End Date & Time'),
                  trailing: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectToDateTime(context),
                  ),
                ),
                const SizedBox(height: 16),
                CustomDropDownHours(
                  value: _eventDurationPerDay,
                  selectedHours: (selectedHours) {
                    setState(() {
                      _eventDurationPerDay = selectedHours;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ColorSelector(
                  initialColor: _selectedColor,
                  onColorSelected: _onColorSelected,
                ),
                const SizedBox(height: 16),
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
      ),
    );
  }
}
