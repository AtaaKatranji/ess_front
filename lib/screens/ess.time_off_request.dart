import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeOffRequestForm extends StatefulWidget {
  @override
  _TimeOffRequestFormState createState() => _TimeOffRequestFormState();
}

class _TimeOffRequestFormState extends State<TimeOffRequestForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 1));
  String _reason = '';

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Off Request Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Reason for Time Off',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a reason for your time off request';
                  }
                  return null;
                },
                onSaved: (value) => _reason = value!,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => _selectStartDate(context),
                      child: Text(
                        'Start Date: ${DateFormat.yMMMd().format(_startDate)}',
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextButton(
                      onPressed: () => _selectEndDate(context),
                      child: Text(
                        'End Date: ${DateFormat.yMMMd().format(_endDate)}',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save the form data to a database or send it to a server
                    print('Time off request submitted: $_reason, $_startDate, $_endDate');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}