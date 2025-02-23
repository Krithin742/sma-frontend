import 'package:flutter/material.dart';
import 'package:student/student/chatbot.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    messages = await chatbotApi({
      'query': 'hello',
    });
    setState(() {});
  }

  // void sendMessage() {
  //   if (messageController.text.trim().isNotEmpty) {
  //     setState(() {
  //       messages.add({"message": messageController.text, "type": "sent"});
  //       messageController.clear();
  //     });

  //     // Simulate a response after a delay
  //     Future.delayed(Duration(milliseconds: 500), () {
  //       setState(() {
  //         messages.add(
  //             {"message": "This is a response message.", "type": "received"});
  //       });
  //     });
  //   }
  // }

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
                reverse: true,
                padding: EdgeInsets.all(10),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  // final isSent = messages[index]["type"] == "sent";
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade600,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.zero,
                            ),
                          ),
                          child: Text(
                            messages[index]["user_query"]!,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Text.rich(
                            TextSpan(
                              children: _parseChatbotResponse(
                                  messages[index]["chatbot_response"]!),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                    onPressed: () async {
                      messages = await chatbotApi({
                        'query': messageController.text,
                      });
                      print(messages);
                      messageController.clear();
                      setState(() {});
                    },
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

// Helper function to parse chatbot response and apply styles
List<TextSpan> _parseChatbotResponse(String response) {
  List<TextSpan> textSpans = [];
  RegExp exp =
      RegExp(r'(\*\*[^*]+\*\*)|([^*]+)'); // Matches **bold** or normal text

  exp.allMatches(response).forEach((match) {
    if (match.group(0)!.startsWith('**')) {
      // If the match is wrapped in **
      textSpans.add(TextSpan(
        text: match
            .group(0)!
            .substring(2, match.group(0)!.length - 2), // Remove ** markers
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ));
    } else {
      // Regular text
      textSpans.add(TextSpan(
        text: match.group(0),
        style: TextStyle(color: Colors.white, fontSize: 16),
      ));
    }
  });

  return textSpans;
}
