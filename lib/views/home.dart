import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/auth/login.dart';
import 'package:to_do_list/views/addTask.dart';
import 'package:to_do_list/views/taskDetails.dart';
import 'package:to_do_list/views/updateTask.dart';

import '../classes/DataClass.dart';
import '../classes/FirestoreService.dart';
import '../classes/notification_controller.dart';
import '../classes/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );
    super.initState();
  }
 // late final Function(bool?)?onChanged;
  //final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<DataClass>(context).tasks;
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'),),
      body: Consumer<DataClass>(builder :(context, dataClass ,child){

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index){
            final task = tasks[index];
            return Card(
                child:GestureDetector(
                  onTap: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TaskDetails(task: task)), (route) => false);},
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child:Row(
                      children: [
                        Checkbox(value: task.isCompleted, onChanged: (bool? value)async {
                          if(task.completed==false){
                            task.completed=true;
                            value=true;

                          }
                          else{
                            {
                              task.completed=false;
                              value=true;

                            }
                          }
                          await context.read<DataClass>().updateTask(task);
                        },
                        checkColor: Colors.teal,),
                        Row(children:[

                            Text("title: ${task.title}"),
                          IconButton(onPressed: ()async{
                            print("task id  to be deleted=${task.getId}");
                           await context.read<DataClass>().deleteTask(task.getId);
                          }, icon: const Icon(CupertinoIcons.delete)),
                          IconButton(onPressed: ()async{
                            print("task id  to be edited=${task.getId}");
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UpdateTask(task: task)), (route) => false);
                          }, icon: const Icon(CupertinoIcons.pen))
                        ]),
                      ],
                    )
                  ),
                )
            );
            }

          );
      }


    ),
       floatingActionButton:FloatingActionButton(
      //   onPressed: () {
      //     AwesomeNotifications().createNotification(
      //         content: NotificationContent(
      //             id: 1,
      //             channelKey: "basic_channel",
      //           title: "Hello Rania",
      //           body:"Yey I have local notifications"
      //         )
      //     );
      //   },
       // child:Icon(Icons.notification_add),
         child:Icon(CupertinoIcons.add),
        onPressed: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AddTask()), (route) => false);},
      ) ,
    );


  }





}
