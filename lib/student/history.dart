import 'package:dio/dio.dart';

Future<List<Map<String, dynamic>>> getHistoryfromapi() async {
  Dio dio = Dio();

  try {
    // Make a GET request to your API endpoint
    Response response = await dio.get('https://api.example.com/data');

    // Check if the response is successful
    if (response.statusCode == 200) {
      // Check if the response data is a List
      if (response.data is List) {
        // Assuming the response is a JSON array of objects
        List<dynamic> data = response.data;

        // Return the data as a List<Map<String, dynamic>>
        return data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        throw Exception('Response is not a list');
      }
    } else {
      throw Exception(
          'Failed to load data, status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle errors
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
