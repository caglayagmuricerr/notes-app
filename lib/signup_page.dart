import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp() async {
    final String username = _usernameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    //////////////////////////////////////////////////////////////////////////
    // Perform input validation here (e.g., check if fields are not empty).//
    ////////////////////////////////////////////////////////////////////////

    // Make the HTTP POST request to your Node.js backend.
    const String url = 'http://localhost:3000/api/user/signup';

    final Map<String, dynamic> data = {
      'username': username,
      'email' : email,
      'password': password,
    };

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(data),
    );
    print(response.body);
    // Process the response from the backend.
    if (response.statusCode == 201) {
      // Successful signup
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      // You can handle the response data here, like navigating to a new page.
      print(responseData);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      // Signup failed
      final Map<String, dynamic> errorData = jsonDecode(response.body);
      final String errorMessage = errorData['message'];
      _showErrorDialog(errorMessage);
    }
  }

  Future<void> _showErrorDialog(String errorMessage) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Signup Failed'),
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
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16),
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
              onPressed: _signUp,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}