import 'package:flutter/material.dart';
import 'package:to_do_list/classes/FirestoreService.dart';
import 'package:to_do_list/classes/task.dart';

class DataClass extends ChangeNotifier{
  final FirestoreService firestoreService;
  List<Tache> _tasks = [];
  DataClass({required this.firestoreService}) {
    subscribeToTasksStream(); // Call to initiate stream subscription
  }
  List<Tache> get tasks => _tasks;

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

}