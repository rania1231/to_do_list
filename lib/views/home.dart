import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/classes/DataClass.dart';
import 'package:to_do_list/views/addTask.dart';
import 'package:to_do_list/views/taskDetails.dart';
import 'package:to_do_list/views/updateTask.dart';
import 'menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<DataClass>(context).tasks;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Color(0xFFDEABAF),
        actions: [
          Menu(),
        ],
      ),
      body: Container(

        color: Colors.grey[200],
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskDetails(task: task)),
                  );
                },
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (bool? value) async {
                        if (task.completed == false) {
                          task.completed = true;
                        } else {
                          task.completed = false;
                        }
                        await context.read<DataClass>().updateTask(task);
                      },
                      checkColor: Colors.white,
                      activeColor: Color(0xFFDC98BD),
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await context.read<DataClass>().deleteTask(task.getId);
                          },
                          icon: Icon(Icons.delete),
                          color: Color(0xFF211A44),

                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UpdateTask(task: task)),
                            );
                          },
                          icon: Icon(Icons.edit),
                          color: Color(0xFFDEABAF),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
        },
        backgroundColor: Color(0xFFDEABAF),
        child: Icon(Icons.add),
      ),
    );
  }
}
