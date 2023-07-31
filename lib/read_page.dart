import 'package:flutter/material.dart';

import 'package:notable_now/colors.dart';
import 'package:notable_now/fonts.dart';

class ReadPage extends StatefulWidget {
  final String title;
  final String text;

  const ReadPage({super.key, required this.title, required this.text});

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pastel.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pastel.backgroundColor,
        title: Text(
          widget.title,
          style: customFontStyle,
        ),
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
              widget.text,
              style: customFontStyle,
            ),
          ],
        ),
      ),
    );
  }
}