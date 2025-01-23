import 'package:flutter/material.dart';

class Convert extends StatefulWidget {
  const Convert({super.key});

  @override
  State<Convert> createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {
  final TextEditingController _fileNameController = TextEditingController();
  String summarizedText =
      'Summarized Text will appear here...'; // Placeholder for the summarized text

  void _saveFile() async {
    // Show dialog to enter file name
    showDialog(
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
                String fileName = _fileNameController.text.trim();
                if (fileName.isNotEmpty) {
                  // Replace this with actual save logic
                  print('Saving file with name: $fileName');
                  print('Content: $summarizedText');

                  // Clear the text field and close the dialog
                  _fileNameController.clear();
                  Navigator.pop(context);

                  // Show confirmation or success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('File "$fileName" saved successfully!')),
                  );
                } else {
                  // Show an error if no file name is provided
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid file name.')),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add your file upload logic here
                  },
                  child: Text('Upload File'),
                ),
              ],
            ),

            SizedBox(height: 16.0),

            // Convert Button
            ElevatedButton(
              onPressed: () {
                // Add your convert logic here
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
            ElevatedButton(
              onPressed: _saveFile,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
