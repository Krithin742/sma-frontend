// import 'package:dio/dio.dart';
// import 'package:student/student/login.dart';

// Future<List<Map<String, dynamic>>> getHistoryfromapi() async {
//   Dio dio = Dio();

//   try {
//     // Make a GET request to your API endpoint
//     Response response = await dio.get('$baseurl/ViewSummaryAPI', data: {
//       'lid': lid,
//     });
//     // print(response.data);
//     // Check if the response is successful
//     print('object');
//     print(response.data);

//     if (response.statusCode == 200) {
//       // Check if the response data is a List
//       print(response.data['summary']);

//       // Assuming the response is a JSON array of objects
//       List<dynamic> data = response.data['summary'];
//       print(data);
//       // Return the data as a List<Map<String, dynamic>>
//       return List<Map<String, dynamic>>.from(data);
//     } else {
//       throw Exception(
//           'Failed to load data, status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     // Handle errors
//     if (e is DioException) {
//       print('Dio error: ${e.message}');
//       if (e.response != null) {
//         print('Response data: ${e.response?.data}');
//       }
//     } else {
//       print('Unknown error: $e');
//     }
//     return [];
//   }
// }

import 'package:dio/dio.dart';
import 'package:student/student/login.dart';

Future<List<Map<String, dynamic>>> getHistoryfromapi() async {
  Dio dio = Dio();

  try {
    // Make a GET request to your API endpoint
    Response response = await dio.get(
      '$baseurl/ViewSummaryAPI',
      data: {'lid': lid},
    );

    // Debugging the entire response
    print('API response: ${response.data}');

    // Check if the response is successful and contains the 'summary' key
    if (response.statusCode == 200 && response.data != null) {
      List<dynamic> summaryList = response.data;
      print('Summary list: $summaryList');

      // Check if the summary list is indeed a list of maps
      if (summaryList is List) {
        List<Map<String, dynamic>> result = [];

        // Iterate over each item in the summaryList and convert to Map
        for (var item in summaryList) {
          if (item is Map<String, dynamic>) {
            result.add(item);
          } else {
            print('Unexpected item type: ${item.runtimeType}');
          }
        }

        // Return the parsed data
        return result;
      } else {
        throw Exception('Expected a list but got ${summaryList.runtimeType}');
      }
    } else {
      throw Exception(
          'Failed to load data or no summary found, status code: ${response.statusCode}');
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
