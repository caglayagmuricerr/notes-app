import 'package:flutter/material.dart';

class ReadPage extends StatefulWidget {
  final String title;
  final String text;

  ReadPage({required this.title, required this.text});

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  /*
  void _editNote() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(title: widget.title, text: widget.text),
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Details'),
        /*actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editNote,
          ),
        ],*/
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.text,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
/*
class EditPage extends StatefulWidget {
  final String title;
  final String text;

  EditPage({required this.title, required this.text});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // Add your editing logic here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              // Save the changes and go back to the ReadPage
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: TextEditingController(text: widget.title),
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: widget.text),
              decoration: InputDecoration(labelText: 'Text'),
            ),
          ],
        ),
      ),
    );
  }
}
 */