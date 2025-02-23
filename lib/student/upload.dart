// import 'package:dio/dio.dart';
// import 'package:student/student/login.dart';

// Future<void> uploadDocument(
//   String filePath,
// ) async {
//   final dio = Dio();

//   try {
//     // Create the form data
//     FormData formData = FormData.fromMap({
//       'file': await MultipartFile.fromFile(filePath,
//           filename: filePath.split('/').last),
//     });

//     // Make the POST request
//     Response response = await dio.post(
//       '$baseurl/upload',
//       data: formData,
//     );

//     // Check response
//     if (response.statusCode == 200) {
//       print("Upload successful: ${response.data}");
//     } else {
//       print("Failed to upload. Status code: ${response.statusCode}");
//     }
//   } catch (e) {
//     print("Error occurred: $e");
//   }
// }
