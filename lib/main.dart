import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/auth/login.dart';
import 'package:to_do_list/auth/splashScreen.dart';
import 'package:to_do_list/classes/FirestoreService.dart';
import 'package:to_do_list/views/addTask.dart';
import 'package:to_do_list/views/home.dart';

import 'auth/register.dart';
import 'classes/DataClass.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDJLYu5WODTItRxAUcjpVWOuwofgRYRArs',
        appId: '1:1032859308336:android:16213b947a0863019438f5',
        messagingSenderId: '1032859308336',
        projectId: 'todolistproject-a7e04',
        storageBucket: 'todolistproject-a7e04.appspot.com',
      )
  );
  FirebaseFirestore.instance.settings= const Settings(persistenceEnabled :true,);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>DataClass(firestoreService: FirestoreService()),
      child:  MaterialApp(
      title: 'Flutter Demo',
    theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    ),
    home: Login(),
    )
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text('home'),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'aaaaa',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

