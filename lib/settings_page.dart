import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:notable_now/colors.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedTheme = 0;

  final List<String> _themeOptions = [
    "Light Theme",
    "Dark Theme",
    "Pastel Theme",
  ];

  void _onThemeOptionChanged(int? value) {
    setState(() async {
      _selectedTheme = value!;
      switch(_selectedTheme){
        case 0:
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('backgroundColor', 'Light.backgroundColor');
          prefs.setString('buttonsColor', 'Light.buttonsColor');
          prefs.setString('index0', 'Light.index0');
          prefs.setString('index1', 'Light.index1');
          prefs.setString('index2', 'Light.index2');
          prefs.setString('index3', 'Light.index3');
          break;
        case 1:
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('backgroundColor', 'Dark.backgroundColor');
          prefs.setString('buttonsColor', 'Dark.buttonsColor');
          prefs.setString('index0', 'Dark.index0');
          prefs.setString('index1', 'Dark.index1');
          prefs.setString('index2', 'Dark.index2');
          prefs.setString('index3', 'Dark.index3');
          break;
        case 2:
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('backgroundColor', 'Pastel.backgroundColor');
          prefs.setString('buttonsColor', 'Pastel.buttonsColor');
          prefs.setString('index0', 'Pastel.index0');
          prefs.setString('index1', 'Pastel.index1');
          prefs.setString('index2', 'Pastel.index2');
          prefs.setString('index3', 'Pastel.index3');
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //////////ADD OTHER SETTINGS
            const SizedBox(height: 20.0),
            Text(
              'Theme',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: _themeOptions
                  .asMap()
                  .map(
                    (index, theme) => MapEntry(
                  index,
                  RadioListTile(
                    title: Text(theme),
                    value: index,
                    groupValue: _selectedTheme,
                    onChanged: _onThemeOptionChanged,//the radio button passes the value to this callback func
                  ),
                ),
              )
                  .values
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}