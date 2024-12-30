import 'package:flutter/material.dart';


class TimetableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  final _formKey = GlobalKey<FormState>();
  int subjectCount = 1;
  List<TextEditingController> subjectControllers = [];
  String selectedPlan = 'Day';

  @override
  void initState() {
    super.initState();
    _initializeSubjectControllers();
  }

  void _initializeSubjectControllers() {
    subjectControllers = List.generate(subjectCount, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in subjectControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitTimetable() {
    if (_formKey.currentState?.validate() ?? false) {
      List<String> subjects = subjectControllers.map((c) => c.text).toList();
      // Perform submission logic here
      print('Subjects: $subjects');
      print('Plan: $selectedPlan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timetable Planner'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Number of Subjects:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: subjectCount.toString(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter number of subjects',
                        ),
                        onChanged: (value) {
                          int? count = int.tryParse(value);
                         

                            setState(() {
                               if (count != null && count > 0) {
                                  subjectCount = count;
                               }
                            
                              _initializeSubjectControllers();
                            });
                          
                        
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Enter Subject Names (difficult to easier!!):',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: subjectCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        controller: subjectControllers[index],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Subject ${index + 1}',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a subject name';
                          }
                          return null;
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Planning:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    RadioListTile<String>(
                      title: Text('Day'),
                      value: 'Day',
                      groupValue: selectedPlan,
                      onChanged: (value) {
                        setState(() {
                          selectedPlan = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('Week'),
                      value: 'Week',
                      groupValue: selectedPlan,
                      onChanged: (value) {
                        setState(() {
                          selectedPlan = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('Month'),
                      value: 'Month',
                      groupValue: selectedPlan,
                      onChanged: (value) {
                        setState(() {
                          selectedPlan = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitTimetable,
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
