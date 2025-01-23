import 'package:dio/dio.dart';

Future<void> loginUser(String username, String password) async {
  final dio = Dio();

  try {
    // Prepare the payload
    final data = {
      'username': username,
      'password': password,
    };

    // Send the POST request to the API
    Response response = await dio.post(
      'https://yourapi.com/login', // Replace with your API endpoint
      data: data,
    );

    // Check if the response status code is 200 (success)
    if (response.statusCode == 200) {
      print("Login successful: ${response.data}");
      // Handle successful login, maybe store token or navigate to a new page
    } else {
      print("Failed to log in: ${response.statusCode}");
      // Handle the failed login response
    }
  } catch (e) {
    print("Error occurred: $e");
    // Handle errors like connection issues or timeouts
  }
}
