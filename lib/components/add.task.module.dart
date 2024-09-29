import 'package:flutter/material.dart';

class OpenModule extends StatefulWidget {
  @override
  _OpenModuleState createState() => _OpenModuleState();
}

class _OpenModuleState extends State<OpenModule> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Enter text here',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Entered text:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(_textEditingController.text),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Add your button logic here
              print('Button pressed');
            },
            child: Text('Click me'),
          ),
        ],
      ),
    );
  }
}
