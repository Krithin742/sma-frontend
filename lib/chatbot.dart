import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final List<Map<String, String>> messages = [];

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add({"message": messageController.text, "type": "sent"});
        messageController.clear();
      });

      // Simulate a response after a delay
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          messages.add(
              {"message": "This is a response message.", "type": "received"});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade300, Colors.blue.shade200],
            begin: Alignment.topLeft, // Start gradient from top-left
            end: Alignment.bottomRight, // End gradient at bottom-right
          ),
        ),
        child: Column(
          children: [
            // Message List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final isSent = messages[index]["type"] == "sent";
                  return Align(
                    alignment:
                        isSent ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: isSent
                            ? Colors.teal.shade600
                            : Colors.blue.shade400,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft:
                              isSent ? Radius.circular(12) : Radius.zero,
                          bottomRight:
                              isSent ? Radius.zero : Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        messages[index]["message"]!,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Message Input
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  // Text Input
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Send Button
                  ElevatedButton(
                    onPressed: sendMessage,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      shape: CircleBorder(),
                      backgroundColor: Colors.white,
                    ),
                    child: Icon(Icons.send, color: Colors.teal.shade800),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
