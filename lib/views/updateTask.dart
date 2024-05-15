import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/classes/DataClass.dart';
import 'package:to_do_list/classes/FirestoreService.dart';
import 'package:to_do_list/views/home.dart';

import '../classes/task.dart';
import 'menu.dart';

class UpdateTask extends StatefulWidget {
  final Tache task;

  UpdateTask({Key? key, required this.task}) : super(key: key);

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  FirestoreService firestoreService = FirestoreService();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  List<String> categories = ['Default', 'Urgent', 'Important', 'Sport', 'Work', 'Study', 'Personal'];
  late DataClass dataClass;
  late String currentCategory;
  late DateTime deadline;

  @override
  void initState() {
    dataClass = DataClass(firestoreService: firestoreService);
    dataClass.editCategory(widget.task.getCategoryId);
    currentCategory = widget.task.getCategoryId;
    title.text = widget.task.getTitle;
    description.text = widget.task.getDescription??"";
    deadline = widget.task.deadline;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDEABAF),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Update Task',),
            Menu(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                "What needs to be done?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: title,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Enter Task Here',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Note",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: description,
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter Note Here',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Category",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: currentCategory,
                items: categories.map((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
                onChanged: (String? val) {
                  setState(() {
                    currentCategory = val!;
                  });
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Deadline",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () async {
                      DateTime? dateTime = await showDatePicker();
                      if (dateTime != null) {
                        setState(() {
                          deadline = dateTime;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_today),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "${deadline.day}/${deadline.month}/${deadline.year}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(

                onPressed: () async {
                  Tache task = Tache(
                    id: widget.task.getId,
                    title: title.text,
                    description: description.text,
                    completed: widget.task.isCompleted,
                    categoryId: currentCategory,
                    createdAt: DateTime.now(),
                    deadline: deadline,
                  );
                  await context.read<DataClass>().updateTask(task);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDEABAF), // Change the background color here
                ),
                child: Text('Update', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> showDatePicker() async {
    return await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(Duration(days: 3652)),
      lastDate: DateTime.now().add(Duration(days: 3652)),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: BorderRadius.all(Radius.circular(16)),
      constraints: BoxConstraints(maxWidth: 350, maxHeight: 650),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(Tween(begin: 0, end: 1)),
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );
  }
}
