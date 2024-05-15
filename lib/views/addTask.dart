import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/classes/FirestoreService.dart';
import 'package:to_do_list/views/home.dart';

import '../classes/DataClass.dart';
import '../classes/task.dart';



class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  FirestoreService firestoreService=FirestoreService();
  TextEditingController taskName=TextEditingController();
  TextEditingController taskDate=TextEditingController();
  List<String> categories=['Default','Urgent'];
  String dropdownValue = 'Default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task', style: TextStyle(fontWeight: FontWeight.bold),)),
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
                        IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.add))
                      ],
                    )
                  ]),
            )
          ],
        ),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: ()async{

          Tache task=Tache(id:"",title:  taskName.text, completed: false,description: "",createdAt: Timestamp.now(),categoryId:dropdownValue );
           context.read<DataClass>().addTask(task);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);

        },
        child: Icon(CupertinoIcons.check_mark),
      ) ,
    );
  }
}
