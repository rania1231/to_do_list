import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/classes/DataClass.dart';
import 'package:to_do_list/classes/FirestoreService.dart';
import 'package:to_do_list/views/home.dart';

import '../classes/task.dart';



class UpdateTask extends StatefulWidget {
   Tache task;
   UpdateTask({super.key, required this.task});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {

  FirestoreService firestoreService=FirestoreService();
  TextEditingController title=TextEditingController();
  TextEditingController dueDate=TextEditingController();
  List<String> categories=['Default','Urgent'];
 late  DataClass dataClass;
 late String currentCategory;



  @override
  void initState() {

     dataClass=DataClass(firestoreService: firestoreService);
     dataClass.editCategory(widget.task.getCategoryId);
     currentCategory=widget.task.getCategoryId;
     title.text=widget.task.getTitle;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Update Task')),
      body:Container(
        child: Column(
        children: [
          Form(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 10),
              Text("What to be done?", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
              Container(height: 20),
              TextFormField(
                controller: title,
                keyboardType: TextInputType.text,
                obscureText: false,
               // initialValue: widget.task.getTitle,
                validator: (val){
                  if(val==null){
                    return 'Cant be empty ';
                  }
                },
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
              TextFormField(
                controller: dueDate,
                //initialValue: (widget.task.getCreatedAt).toString(),
                obscureText: false,
                keyboardType: TextInputType.datetime,
                validator: (val){
                  if(val==null){
                    return 'Can not be empty';
                  }
                },
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
              Consumer<DataClass>(builder :(context, dataClass ,child){
                return DropdownButton(
                    value: currentCategory,
                    items: categories.map<DropdownMenuItem<String>>(
                            (String val){
                          return DropdownMenuItem<String>(value: val,child: Text(val),);
                        }

                    ).toList()


                    , onChanged: (String? val ){
                  context.read<DataClass>().editCategory(val!);
                  currentCategory=val;
                });
              } ,),



            ],
          ),

          ),
          ElevatedButton(onPressed:()async{
            Tache task=Tache(id: widget.task.getId,title:title.text, completed: widget.task.isCompleted, categoryId: currentCategory, createdAt: Timestamp.now(),);
           await context.read<DataClass>().updateTask(task);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
          }, child: Text('update'))
        ],
        ),
      ),
    );
  }
}


