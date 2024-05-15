import 'package:flutter/material.dart';
import '../classes/task.dart';
import 'menu.dart';

class TaskDetails extends StatelessWidget {
  final Tache task;

  const TaskDetails({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
          style: TextStyle(color: Colors.black), // Text color
        ),
        backgroundColor:Color(0xFFDEABAF), // Appbar background color
        elevation: 0, // Remove appbar shadow
        iconTheme: IconThemeData(color: Colors.black), // Icon color
        actions: [
          Menu(),
        ],
      ),
      backgroundColor: Color(0xFFDEABAF), // Scaffold background color
      body: Padding(
        padding: const EdgeInsets.all(8.0),

          child: Container(
            height: 600,
            width: 390,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all( Radius.circular(30.0)),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                  Text(
                    'Title:',
                    style: TextStyle(color: Color(0xFF81657C),fontWeight: FontWeight.bold,fontSize: 25),
                  ),
                  SizedBox(height: 5),
                  Text(
                    task.title,
                    style: TextStyle(color: Colors.black,fontSize: 22),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Category:',
                    style: TextStyle(color: Color(0xFF81657C),fontWeight: FontWeight.bold,fontSize: 25),
                  ),
                  SizedBox(height: 5),
                  Text(
                    task.categoryId,
                    style: TextStyle(color: Colors.black,fontSize: 22),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Date:',
                    style: TextStyle(color: Color(0xFF81657C),fontWeight: FontWeight.bold,fontSize: 25),
                  ),
                  SizedBox(height: 5),
                  Text(
                    task.createdAt.toString(),
                    style: TextStyle(color: Colors.black,fontSize: 22),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Completed:',
                    style: TextStyle(color: Color(0xFF81657C),fontWeight: FontWeight.bold,fontSize: 25),
                  ),
                  SizedBox(height: 5),
                  Text(
                    task.isCompleted.toString(),
                    style: TextStyle(color: Colors.black,fontSize: 22),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Deadline:',
                    style: TextStyle(color: Color(0xFF81657C),fontWeight: FontWeight.bold,fontSize: 25),
                  ),
                  SizedBox(height: 5),
                  Text(
                    task.deadline.toString(),
                    style: TextStyle(color: Colors.black,fontSize: 22),
                  ),
                ],
              ),
            ),
          ),

      ),
    );
  }
}
