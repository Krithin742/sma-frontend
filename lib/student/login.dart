import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student/homepage.dart';

String baseurl = "http://192.168.1.49:5000";
int? lid;
Future<void> loginUser(String username, String password, context) async {
  final dio = Dio();

  try {
    // Prepare the payload
    final data = {
      'username': username,
      'password': password,
    };

    // Send the POST request to the API
    Response response = await dio.post(
      '$baseurl/login', // Replace with your API endpoint
      data: data,
    );

    // Check if the response status code is 200 (success)
    if (response.statusCode == 200) {
      lid = response.data['login_id'];
      print("Login successful: ${response.data}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));
      // Handle successful login, maybe store token or navigate to a new page
    } else {
      print("Failed to log in: ${response.statusCode}");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('failed')));
      // Handle the failed login response
    }
  } catch (e) {
    print("Error occurred: $e");
    // Handle errors like connection issues or timeouts
  }
}
