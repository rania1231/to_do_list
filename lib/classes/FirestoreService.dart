import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void>addTask(Task task)async{
    //generate a unique id
    final String id=_db.collection('tasks').doc().id;
  }




  // Future<void> addUser(UserCredential userCredential) {
  //   CollectionReference users = _db.collection('users');
  //   User? user = userCredential.user;
  //   if (user != null) {
  //     return users
  //         .doc(user.uid)
  //         .set({
  //       'uid': user.uid,
  //       'username': username.text,
  //       'email': email.text ,
  //       'password': password.text,
  //       'phoneNumber': phoneNumber.text,
  //       'imageUrl': imageUrl.text,
  //       'dureeAlerte': 90,
  //       'historiques': {},
  //     })
  //         .then((value) => print("User Added"))
  //         .catchError((error) => print("Failed to add user: $error"));
  //   } else {
  //     print("User is null");
  //     // Gérer le cas où l'utilisateur est null
  //     return Future.error("User is null");
  //   }
  // }



}


