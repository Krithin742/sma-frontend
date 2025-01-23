import 'package:dio/dio.dart';

Future<void> registerUser(
    String username, String mobileNumber, String password) async {
  final dio = Dio();

  try {
    // Payload for the request
    final data = {
      'username': username,
      'mobile_number': mobileNumber,
      'password': password,
    };

    // Send POST request to the API
    Response response = await dio.post(
      'https://yourapi.com/register', // Replace with your API URL
      data: data,
    );

    // Check response status code
    if (response.statusCode == 201 || response.statusCode == 200) {
      print("Registration successful: ${response.data}");
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
