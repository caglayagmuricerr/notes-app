import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notable_now/read_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<dynamic> notes = []; // List to store the received notes

  @override
  void initState() {
    super.initState();
    // Call the getNotes() function when the homepage is first loaded
    getNotes();
  }

  Future<void> getNotes() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/notes/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Auth': 'Bearer ${prefs.getString('token')}'
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          notes = data['notes'];
        });
      } else {
        print('Error: ${response.statusCode}');
        // ERROR CASES
      }
    } catch (error) {
      print('Error: $error');
      // OTHER ERRORS
    }
  }

  Future<void> _showAddNoteDialog() async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController textController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: textController,
                decoration: const InputDecoration(labelText: 'Text'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await saveNote(titleController.text, textController.text);
                await getNotes(); // Wait for the note to be saved before retrieving all notes
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveNote(String title, String text) async {
    const String url = 'http://localhost:3000/api/notes/';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> data = {
      'title': title,
      'text': text,
    };
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Auth': 'Bearer ${prefs.getString('token')!}'
      },
      body: jsonEncode(data),
    );
  }

  // Function to edit a note by its index
  void _editNote(int index) async {
    final TextEditingController titleController = TextEditingController(text: notes[index]['title']);
    final TextEditingController textController = TextEditingController(text: notes[index]['text']);

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Note'),
          content: SizedBox(
            height: 500,
            width: 700,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: textController,
                    maxLines: null, // Allow the text field to have unlimited lines (scrollable)
                    keyboardType: TextInputType.multiline, // Enable multiline input
                    decoration: const InputDecoration(labelText: 'Text'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await updateNote(index, titleController.text, textController.text);
                await getNotes(); // Refresh the notes after editing
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Function to update the note on the server
  Future<void> updateNote(int index, String title, String text) async {
    final String url = 'http://localhost:3000/api/notes/${notes[index]['_id']}';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, String>> data =
      [{ "propName": "title", "value": title },  { "propName": "text", "value": text }]
    ;
    await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Auth': 'Bearer ${prefs.getString('token')!}'
      },
      body: jsonEncode(data),
    );
  }

  // Function to delete a note by its index
  void _deleteNote(int index) async {
    final String url = 'http://localhost:3000/api/notes/${notes[index]['_id']}';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Auth': 'Bearer ${prefs.getString('token')!}'
      },
    );
    await getNotes(); // Refresh the notes after deletion
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              final title = note['title'];
              final text = note['text'];

              return NoteWidget(
                title: title,
                text: text,
                onEdit: () => _editNote(index), // Pass the edit function
                onDelete: () => _deleteNote(index), // Pass the delete function
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () => _showAddNoteDialog(),
          child: const Text('Add New Note'),
        ),
      ],
    );
  }
}

class NoteWidget extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const NoteWidget({super.key,
    required this.title,
    required this.text,
    required this.onEdit,
    required this.onDelete,
  });

  void goToReadPage(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReadPage(
          title: title,
          text: text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => goToReadPage(context),
        child: Card(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      iconSize: 20.0,
                      onPressed: onEdit,
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      iconSize: 20.0,
                      onPressed: onDelete,
                      color: Colors.white,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    title.length <= 15
                        ? title
                        : "${title.substring(0, 15)}...",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    text.length <= 50
                        ? text
                        : "${text.substring(0, 50)}...",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





