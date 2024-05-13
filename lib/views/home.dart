import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/auth/login.dart';

import '../classes/DataClass.dart';
import '../classes/FirestoreService.dart';
import '../classes/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<DataClass>(context).tasks;
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'),),
      body: Consumer<DataClass>(builder :(context, dataClass ,child){
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index){
            final task = tasks[index];
            return Card(
                child:Container(
                  padding: EdgeInsets.all(10),
                  child:Column(children:[
                      Text("title: ${task.title}"),
                      Text("Categorie: ${task.categoryId}"),
                      Text("date: ${(task.createdAt).toString()}"),
                      Text("completed: ${(task.isCompleted).toString()}"),
                  ])
                )
            );
            }

          );
      }


    )
    );


  }





}
