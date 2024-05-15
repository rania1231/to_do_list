import 'package:flutter/material.dart';

import '../classes/task.dart';


class TaskDetails extends StatefulWidget {
  Tache task;
   TaskDetails({super.key,required this.task});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),


      ),
      body: Container(
        child: Column(
          children: [
            Text('Title:   ${widget.task.title}' ),
            Text("Categorie: ${widget.task.categoryId}"),
            Text("date: ${(widget.task.createdAt)}"),
            Text("completed: ${(widget.task.isCompleted)}"),
            Text("deadline: ${(widget.task.deadline)}"),
          ],
        ),
      ),
    );
  }
}
