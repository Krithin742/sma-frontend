import 'package:flutter/material.dart';
import 'package:student/Alarm.dart';
import 'package:student/activity.dart';
import 'package:student/convert.dart';
import 'package:student/chatbot.dart';
import 'package:student/student/history.dart'; // Ensure this path is correct

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> historydata = [
    {
      "files": [
        {
          "file_name": "file1.pdf",
          "file_url": "https://example.com/file1.pdf",
        },
        {
          "file_name": "file2.pdf",
          "file_url": "https://example.com/file2.pdf",
        },
      ],
    },
    {
      "files": [
        {
          "file_name": "file3.pdf",
          "file_url": "https://example.com/file3.pdf",
        },
        {
          "file_name": "file4.pdf",
          "file_url": "https://example.com/file4.pdf",
        },
      ],
    },
  ];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  void fetch() async {
    setState(() {
      isLoading = true;
    });
    historydata = await getHistoryfromapi();
    print(historydata);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        fetch();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 58, 150, 226),
          title: const Text('SnapSumm'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF85D8CE), Color(0xFF4EABE3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Welcome to SnapSumm",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                if (isLoading)
                  CircularProgressIndicator()
                else if (historydata.isEmpty)
                  Expanded(child: Text("No history data"))
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: historydata.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => SavedFilesScreen(
                              //         savedFiles: historydata[index]["files"],
                              //       ),
                              //     ));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FileDetailScreen(
                                    file: historydata[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    " ${historydata[index]["title"] ?? 'Unknown File'}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward, color: Colors.teal),
                                  // const SizedBox(height: 10),
                                  // Text(
                                  //   "Converted file ${historydata[index]["files"].length}",
                                  //   style: const TextStyle(fontSize: 16),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                // Expanded(
                //     child: ListView.builder(
                //   itemCount: 6,
                //   itemBuilder: (context, index) {
                //     return Padding(
                //       padding: const EdgeInsets.all(2.0),
                //       child: InkWell(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => SavedFilesScreen(
                //                   savedFiles: [],
                //                 ),
                //               ));
                //         },
                //         child: Container(
                //           width: double.infinity,
                //           padding: const EdgeInsets.all(20.0),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(20),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Colors.black.withOpacity(0.1),
                //                 blurRadius: 10,
                //                 offset: const Offset(0, 4),
                //               ),
                //             ],
                //           ),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: const [
                //               Text(
                //                 "No converted files yet.",
                //                 style: TextStyle(
                //                   fontSize: 20,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //               SizedBox(height: 10),
                //               Text(
                //                 "Converted file ",
                //                 style: TextStyle(fontSize: 16),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // )),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _iconWithText(Icons.calendar_month, "Reminder", () {
                      print('Reminder clicked');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AlarmSettingScreen()),
                      );
                    }),
                    _iconWithText(Icons.assignment, "Summarize File", () {
                      print('Summarize File clicked');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Convert()),
                      );
                    }),
                    _iconWithText(Icons.chat_bubble_outline, "ChatBot", () {
                      print('ChatBot clicked');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconWithText(IconData icon, String label, GestureTapCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                color: const Color(0xFF4EABE3),
                size: 35,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
