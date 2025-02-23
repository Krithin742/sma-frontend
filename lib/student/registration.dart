import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student/student/login.dart';

Future<void> registerUser(
    String username, String mobileNumber, String password,context) async {
  final dio = Dio();

  try {
    // Payload for the request
    final data = {
      'user_name': username,
      'phone_number': mobileNumber,
      'password': password,
    };

    // Send POST request to the API
    Response response = await dio.post(
      '$baseurl/user_registration', // Replace with your API URL
      data: data,
    );
    print(response.data);
    // Check response status code
    if (response.statusCode == 201 || response.statusCode == 200) {
      print("Registration successful: ${response.data}");
      Navigator.pop(context);
      // Handle success (e.g., navigate to login screen)
    } else {
      print("Failed to register: ${response.statusCode}");
      // Handle failure
    }
  } catch (e) {
    print("Error occurred during registration: $e");
    // Handle exceptions (e.g., timeout, network issues)
  }
}
