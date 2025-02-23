import 'package:dio/dio.dart';
import 'package:student/student/login.dart';

Future<List<Map<String, dynamic>>> chatbotApi(
    Map<String, dynamic> requestData) async {
  Dio dio = Dio(); // Initialize Dio

  try {
    // Make a POST request to your API endpoint
    Response response = await dio.post(
      '$baseurl/chatbotapi', // Replace with your actual API endpoint
      data: requestData, // Sending request data in the body
    );
// print(response.data);
    // Check if the response is successful (status code 200)
    if (response.statusCode == 200) {
      // Check if the response data is a List

      List<Map<String, dynamic>> responseData =
          List<Map<String, dynamic>>.from(response.data['chat_history']);
      print(responseData);
      // Convert the response data to List<Map<String, dynamic>> and return
      return responseData;
    } else {
      throw Exception(
          'Failed to load data, status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle errors, including Dio errors and other exceptions
    if (e is DioException) {
      print('Dio error: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
      }
    } else {
      print('Unknown error: $e');
    }
    return [];
  }
}
