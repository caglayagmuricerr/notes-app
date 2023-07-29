import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notable_now/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    //////////////////////////////////////////////////////////////////////////
    // Perform input validation here (e.g., check if fields are not empty).//
    ////////////////////////////////////////////////////////////////////////

    // Make the HTTP POST request to your Node.js backend.
    const String url = 'http://localhost:3000/api/user/login';

    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(data),
    );

    final dynamic responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Successful login
      final String? token = responseData['token'];
      final String? userId = responseData['userId'];

      if (token != null && userId != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('userId', userId);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        _showErrorDialog('Invalid response data. Missing token or userId.');
      }
    } else {
      // Login failed
      final String? errorMessage = responseData['message'];
      _showErrorDialog(errorMessage ?? 'Unknown error occurred.');
    }
  }

  Future<void> _showErrorDialog(String errorMessage) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 8), // Add some space between the buttons
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: const Text("Don't have an account? Create one"),
            ),
          ],
        ),
      ),
    );
  }
}