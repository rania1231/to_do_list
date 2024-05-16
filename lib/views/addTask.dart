import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/classes/FirestoreService.dart';
import 'package:to_do_list/views/home.dart';

import '../classes/DataClass.dart';
import '../classes/task.dart';
import 'menu.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart'as tz;

class AddTask extends StatefulWidget {
  const AddTask({Key? key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  FirestoreService firestoreService = FirestoreService();
  TextEditingController taskName = TextEditingController();
  TextEditingController description = TextEditingController();
  List<String> categories = ['Default', 'Urgent', 'Important', 'Sport', 'Work', 'Study', 'Personal'];
  String dropdownValue = 'Default';
  late DateTime deadline;
  late DataClass dataClass;



  @override
  void initState() {
    tz.initializeTimeZones();

// Get the local time zone

    dataClass = DataClass(firestoreService: firestoreService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task', style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFDEABAF),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Menu(),
        ],
      ),
      backgroundColor: Color(0xFFDEABAF),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text("What needs to be done?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  controller: taskName,
                  decoration: InputDecoration(
                    hintText: 'Enter Task Here',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text("Note", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  controller: description,
                  decoration: InputDecoration(
                    hintText: 'Note',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(
                    children: [
                      Text("Category", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),


                    ],
                  ),
                  Row(
                    children: [
                      Text("Deadline", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () async {
                          DateTime? dateTime = await showDatePicker();
                          if (dateTime != null) {
                            setState(() {
                              deadline = dateTime;
                            });
                          }
                        },
                        icon: Icon(Icons.calendar_month),
                      )
                    ],
                  ),
                ],),
                DropdownButton<String>(
                  value: dropdownValue,
                  items: categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                ),

                //SizedBox(height: 10),

              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFDEABAF),
        onPressed: () async {
          Tache task = Tache(
            id: "",
            title: taskName.text,
            completed: false,
            description: description.text,
            createdAt: DateTime.now(),
            categoryId: dropdownValue,
            deadline: deadline,
          );
          context.read<DataClass>().addTask(task);
          await sendNotif(deadline, task.completed);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
        },
        child: Icon(CupertinoIcons.check_mark),
      ),
    );
  }

  Future<DateTime?> showDatePicker() async {
    return await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(const Duration(days: 3652)),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
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
  Future<void>sendNotif(DateTime deadline, bool completed)async{


// Get the local time zone
    final localTimeZone = tz.local;
    print(localTimeZone);
    if(!completed){
      if (deadline != null) {
        // Compare the deadline with the current date
        if (DateTime.now().isAfter(deadline)) {
          // If the current date is after the deadline, schedule the notification
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: UniqueKey().hashCode,
              channelKey: "basic_channel",
              title: "Task Deadline Exceeded",
              body: "Your task deadline has been exceeded!",
            ),
            schedule: NotificationInterval(
              interval: 0,
              timeZone: (localTimeZone).toString(),
              repeats: false,
              preciseAlarm: true,
            ),
          );

        } else {
          // If the current date is before the deadline, set a timer to schedule the notification when the deadline is reached
          Duration difference = deadline.difference(DateTime.now());
          Timer(difference, () async {

            await AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: UniqueKey().hashCode,
                channelKey: "basic_channel",
                title: "Task Deadline Exceeded",
                body: "Your task deadline has been exceeded!",
              ),

            );
          });
        }
      }
    }

  }
}
