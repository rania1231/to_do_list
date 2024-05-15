import 'dart:async';


import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/classes/FirestoreService.dart';
import 'package:to_do_list/views/home.dart';

import '../classes/DataClass.dart';
import '../classes/task.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart'as tz;

import 'menu.dart';



class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  FirestoreService firestoreService=FirestoreService();
  TextEditingController taskName=TextEditingController();
  TextEditingController taskDate=TextEditingController();
  List<String> categories=['Default','Urgent','Important','Sport','Work','Study','Personal'];
  String dropdownValue = 'Default';
  late tz.Location localTimeZone;
  late DateTime deadline;
  late  DataClass dataClass;

  @override
  void initState() {
    // TODO: implement initState
    dataClass=DataClass(firestoreService: firestoreService);
    tz.initializeTimeZones();

// Get the local time zone
    localTimeZone = tz.local;
    print('LocalTimeZone=$localTimeZone');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title:  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('New Task'),
        Menu()
      ],
    ),),
      body: Container(
        child: Column(
          children: [
            Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 10),

                    // Center(child: Text("Sign Up", style: TextStyle(fontSize:50, fontWeight:  FontWeight.bold),)),

                    Text("What to be done?", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                    Container(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      validator: (val){
                        if(val== ""){
                          return "Can't be empty";
                        }
                      },
                      controller: taskName,
                      decoration: InputDecoration(
                          hintText: 'Enter Task Here', hintStyle:   TextStyle(color: Colors.grey[400]),
                          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.grey)
                          )
                      ),
                    ),


                    Container(height: 20),

                    Text("Due date", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                    Container(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.datetime,
                      obscureText: false,
                      controller: taskDate,
                      decoration: InputDecoration(
                          hintText: 'No date set', hintStyle:   TextStyle(color: Colors.grey[400]),
                          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.grey)
                          )
                      ),
                    ),

                    Container(height: 20),

                    Text("Categorie", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                    Container(height: 20),
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: dropdownValue,
                          items: categories.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),

                          onChanged:  (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },),
                        IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.add)),

                      ],
                    )
                  ]),
            ),
            ElevatedButton(onPressed: ()async{
             DateTime? dateTime=await showDatePicker();
             print('dateTime=$dateTime');
             deadline=dateTime!;
            }, child: Text('get deadline of your task')),


      ElevatedButton(
        onPressed: () async {
          final localTimeZone = tz.local;
          DateTime? deadline = await showDatePicker();
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
        },
        child: Text('Set Deadline'),
      ),
          ],
        ),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: ()async{

          Tache task=Tache(id:"",title:  taskName.text, completed: false,description: "",createdAt: DateTime.now(),categoryId:dropdownValue ,deadline:deadline );
           context.read<DataClass>().addTask(task);
          dataClass.sendNotif(task.deadline, task.completed);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);

        },
        child: Icon(CupertinoIcons.check_mark),
      ) ,
    );
  }

  Future<DateTime?> showDatePicker()async {
    return await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:
      DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
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
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );
  }




}
