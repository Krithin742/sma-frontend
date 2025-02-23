// import 'package:flutter/material.dart';

// class Convert extends StatefulWidget {
//   const Convert({super.key});

//   @override
//   State<Convert> createState() => _ConvertState();
// }

// class _ConvertState extends State<Convert> {
//   final TextEditingController _fileNameController = TextEditingController();
//   String summarizedText =
//       'Summarized Text will appear here...'; // Placeholder for the summarized text

//   void _saveFile() async {
//     // Show dialog to enter file name
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Save File'),
//           content: TextField(
//             controller: _fileNameController,
//             decoration: InputDecoration(
//               labelText: 'Enter file name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 String fileName = _fileNameController.text.trim();
//                 if (fileName.isNotEmpty) {
//                   // Replace this with actual save logic
//                   print('Saving file with name: $fileName');
//                   print('Content: $summarizedText');

//                   // Clear the text field and close the dialog
//                   _fileNameController.clear();
//                   Navigator.pop(context);

//                   // Show confirmation or success message
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content: Text('File "$fileName" saved successfully!')),
//                   );
//                 } else {
//                   // Show an error if no file name is provided
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Please enter a valid file name.')),
//                   );
//                 }
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Summarizer'),
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Upload File Button
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Add your file upload logic here
//                   },
//                   child: Text('Upload File'),
//                 ),
//               ],
//             ),

//             SizedBox(height: 16.0),

//             // Convert Button
//             ElevatedButton(
//               onPressed: () {
//                 // Add your convert logic here
//               },
//               child: Text('Convert'),
//             ),

//             SizedBox(height: 16.0),

//             // Summarized Text Section
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Text(
//                     summarizedText,
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(height: 16.0),

//             // Save Button
//             ElevatedButton(
//               onPressed: _saveFile,
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:student/student/login.dart'; // Import dio package for making API calls

class Convert extends StatefulWidget {
  const Convert({super.key});

  @override
  State<Convert> createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {
  final TextEditingController _fileNameController = TextEditingController();
  String summarizedText =
      'Summarized Text will appear here...'; // Placeholder for the summarized text

  // Function to pick a PDF file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      // Extract text from the selected PDF
      String extractedText = await _sendFileToServer(file);
      // Summarize the extracted text

      setState(() {
        summarizedText = extractedText; // Update the UI with summarized text
      });
    } else {
      // User canceled the picker
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No file selected')));
    }
  }

  // Function to extract text from PDF (simulated in this case)
  // Future<String> _extractTextFromPDF(File file) async {
  //   // For simplicity, we're simulating the extraction. Replace with actual extraction logic.
  //   String pdfContent = 'This is an extracted text from the PDF document...'; // Replace with actual PDF text extraction logic
  //   return pdfContent;
  // }

  // Function to simulate text summarization
  // String _summarizeText(String text) {
  //   // In real-world, you could call an API for summarization.
  //   return text.substring(0, text.length > 100 ? 100 : text.length) + '...'; // Simulate summarization by truncating text
  // }

  void showAlertDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Save File'),
          content: TextField(
            controller: _fileNameController,
            decoration: InputDecoration(
              labelText: 'Enter file name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _saveFile();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Function to handle save button press (Post API logic using Dio)
  void _saveFile() async {
    String fileName = _fileNameController.text.trim();

    if (fileName.isNotEmpty) {
      Dio dio = Dio();
      try {
        var response = await dio.post(
          '$baseurl/api/save-summary/', // Replace with actual URL
          data: {
            'lid':lid,
            'fileName': fileName,
            'content': summarizedText,
          },
        );

        if (response.statusCode == 200) {
          _fileNameController.clear();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('File "$fileName" saved successfully!')));
        } else {
          _fileNameController.clear();
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Failed to save the file')));
        }
      } catch (e) {
        // Navigator.pop(context);
        print(e);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }

      // Clear the text field after saving
      _fileNameController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid file name.')));
    }
  }

  // Function to send picked file to server and get response
  Future<String> _sendFileToServer(File file) async {
    Dio dio = Dio();
    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    try {
      var response = await dio.post(
        '$baseurl/api/summarize-pdf/', // Replace with actual URL
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['summary'];
      } else {
        throw Exception('Failed to upload file');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summarizer'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Upload File Button
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       height: 35,
            //       width: double.infinity,
            //       child: ElevatedButton(
            //         style: ButtonStyle(
            //           backgroundColor: WidgetStatePropertyAll(Colors.teal),
            //         ),
            //         onPressed: _pickFile, // Open file picker for PDF
            //         child: Text('Upload File'),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 16.0),

            // Convert Button (Placeholder)
            ElevatedButton(
              onPressed: () {
                // _sendFileToServer(File('path/to/file.pdf')).then((response) {
                //   // Handle response from server
                // }).catchError((error) {
                //   // Handle error
                //   print(error);
                // });
                _pickFile();

                // Add your convert logic here if necessary
              },
              child: Text('Convert'),
            ),

            SizedBox(height: 16.0),

            // Summarized Text Section
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    summarizedText,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.0),

            // Save Button
            Container(
              height: 35,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.teal),
                ),
                onPressed: () {
                  showAlertDialog(context);
                }, // Save function using Dio for API call
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
