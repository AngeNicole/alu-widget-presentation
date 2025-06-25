import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino Date Time Demo',
      home: DateTimePickerDemo(),
    );
  }
}

class DateTimePickerDemo extends StatefulWidget {
  @override
  _DateTimePickerDemoState createState() => _DateTimePickerDemoState();
}

class _DateTimePickerDemoState extends State<DateTimePickerDemo> {
  DateTime selectedDate = DateTime.now();
  DateTime selectedTime = DateTime.now();
  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Date & Time Pickers'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Picker Section
              _buildSectionTitle('Date Picker'),
              _buildSelectedValue('Selected Date: ${_formatDate(selectedDate)}'),
              Container(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate,
                  minimumDate: DateTime(2020),
                  maximumDate: DateTime(2030),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      selectedDate = newDate;
                    });
                  },
                ),
              ),
              
              SizedBox(height: 30),
              
              // Time Picker Section
              _buildSectionTitle('Time Picker'),
              _buildSelectedValue('Selected Time: ${_formatTime(selectedTime)}'),
              Container(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: selectedTime,
                  use24hFormat: false,
                  minuteInterval: 1,
                  onDateTimeChanged: (DateTime newTime) {
                    setState(() {
                      selectedTime = newTime;
                    });
                  },
                ),
              ),
              
              SizedBox(height: 30),
              
              // Date and Time Picker Section
              _buildSectionTitle('Date & Time Picker'),
              _buildSelectedValue('Selected: ${_formatDateTime(selectedDateTime)}'),
              Container(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: selectedDateTime,
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      selectedDateTime = newDateTime;
                    });
                  },
                ),
              ),
              
              SizedBox(height: 30),
              
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CupertinoButton.filled(
                    child: Text('Show Date Modal'),
                    onPressed: () => _showDateModal(context),
                  ),
                  CupertinoButton.filled(
                    child: Text('Show Time Modal'),
                    onPressed: () => _showTimeModal(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: CupertinoColors.label,
        ),
      ),
    );
  }

  Widget _buildSelectedValue(String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: CupertinoColors.label,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime time) {
    String period = time.hour >= 12 ? 'PM' : 'AM';
    int hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    return '${hour}:${time.minute.toString().padLeft(2, '0')} $period';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${_formatDate(dateTime)} ${_formatTime(dateTime)}';
  }

  void _showDateModal(BuildContext context) {
    DateTime tempDate = selectedDate;
    
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        padding: EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Container(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        setState(() {
                          selectedDate = tempDate;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: tempDate,
                  onDateTimeChanged: (DateTime newDate) {
                    tempDate = newDate;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTimeModal(BuildContext context) {
    DateTime tempTime = selectedTime;
    
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        padding: EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Container(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        setState(() {
                          selectedTime = tempTime;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: tempTime,
                  use24hFormat: false,
                  onDateTimeChanged: (DateTime newTime) {
                    tempTime = newTime;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
