import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/classes/FirestoreService.dart';
import 'package:to_do_list/classes/task.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart'as tz;

class DataClass extends ChangeNotifier{
  final FirestoreService firestoreService;
  List<Tache> _tasks = [];
  DataClass({required this.firestoreService}) {
    subscribeToTasksStream(); // Call to initiate stream subscription
  }
  List<Tache> get tasks => _tasks;
  String currentCategory='Default';


  Future<void> addTask(Tache task)async{
    print("1-length of _tasks=${_tasks.length}");
    await firestoreService.addTask(task);
    print("2-length of _tasks=${_tasks.length}");
    print("Data class: taskid=${task.getId}");

    print("3-length of _tasks=${_tasks.length}");
    notifyListeners();
  }

  Future<void> updateTask(Tache task) async {
    // Implement logic to update task in Firestore using firestoreService
    await firestoreService.updateTask(task); // Example call

    // Update internal state after successful update
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
    notifyListeners();
  }

  Future<void> deleteTask(String taskId) async {
    // Implement logic to delete task from Firestore using firestoreService
    await firestoreService.deleteTask(taskId); // Example call

    // Update internal state after successful deletion
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  Future<void> subscribeToTasksStream() async {
    print("task here before initialize: tasks's length=${tasks.length}");
    Stream<List<Tache>> tasksStream =await  firestoreService.getTasks();
    print("taskStream length= ${tasksStream.length}");
    tasksStream.listen((tasks) {
      _tasks = tasks;
      notifyListeners();
    });
  }

  void editCategory(String s) {
    currentCategory=s;
    notifyListeners();
  }

  Future<void>sendNotif(DateTime deadline, bool completed)async{
    tz.initializeTimeZones();

// Get the local time zone
    final localTimeZone = tz.local;
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