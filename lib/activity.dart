import 'package:flutter/material.dart';

class SavedFilesScreen extends StatelessWidget {
  final List<Map<String, String>>
      savedFiles; // List of files with their names and content

  const SavedFilesScreen({super.key, required this.savedFiles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Files'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: savedFiles.isEmpty
          ? Center(
              child: Text(
                'No files saved yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: savedFiles.length,
              itemBuilder: (context, index) {
                final file = savedFiles[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(file['name'] ?? 'Unknown File'),
                    subtitle: Text(
                      file['content'] ?? 'No content available',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Navigate to detail screen to show file content
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FileDetailScreen(
                            fileName: file['name'] ?? 'Unknown File',
                            fileContent:
                                file['content'] ?? 'No content available',
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class FileDetailScreen extends StatelessWidget {
  final String fileName;
  final String fileContent;

  const FileDetailScreen({
    super.key,
    required this.fileName,
    required this.fileContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fileName),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            fileContent,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
