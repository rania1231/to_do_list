import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/views/taskDetails.dart';
import 'package:to_do_list/views/updateTask.dart';

import '../classes/DataClass.dart';
import '../classes/task.dart';


class CategoryTasksPage extends StatelessWidget {
  final String category;

  const CategoryTasksPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve tasks based on the selected category
    List<Tache> categoryTasks = Provider.of<DataClass>(context)
        .tasks
        .where((task) => task.getCategoryId == category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks - $category'),
      ),
      body: ListView.builder(
        itemCount: categoryTasks.length,
        itemBuilder: (context, index) {
          final task = categoryTasks[index];
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

                          Text(
                            "title: ${task.title}",
                            style: TextStyle(
                              decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                            ),
                          ),
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

        },
      ),
    );
  }
}
