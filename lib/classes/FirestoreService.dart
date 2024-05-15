import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:to_do_list/classes/task.dart';

import '../views/home.dart';

class FirestoreService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late final String _userId;
  FirestoreService(){
    _userId=FirebaseAuth.instance.currentUser!.uid;
  }


  Future<void>addTask(Tache task)async{
    //generate a unique id
    final docRef=_db.collection('users').doc(_userId).collection('tasks').doc();
    task.setId((docRef.id).toString());
    await docRef.set({
      'id':task.getId,
    'title':task.getTitle,
    'description':task.getDescription,
    'completed':task.isCompleted,
    'categorie':task.getCategoryId ,
    'createdAt':task.getCreatedAt,
      'deadline':task.deadline
    });
    print("task details being added: taskid=${task.getId}, taskTitle=${task.title}");

  }

  // Delete task method
  Future<void> deleteTask(String taskId) async {

    await _db
        .collection('users')
        .doc(_userId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

  // Update task method
  Future<void> updateTask(Tache task) async {
    await _db
        .collection('users')
        .doc(_userId)
        .collection('tasks')
        .doc(task.getId)
        .update({
      'title': task.getTitle,
      'description': task.getDescription,
      'completed': task.isCompleted,
      'categorie': task.getCategoryId,
      'deadline':task.deadline
    });
  }

  // View tasks method (stream for live updates)
  Stream<List<Tache>> getTasks() {
    return _db
        .collection('users')
        .doc(_userId)
        .collection('tasks')
        .snapshots()
        .map((snapshot) {

      return snapshot.docs.map((doc) => Tache.fromFirestore(doc.data()!)).toList();
    });
  }

  Future<void> addUser(UserCredential userCredential,String userName,String email,String pass) {
    CollectionReference users = _db.collection('users');
    User? user = userCredential.user;
    if (user != null) {
      return users
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'username': userName,
        'email': email,
        'password': pass
      })

          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

    } else {
      print("User is null");
      // Gérer le cas où l'utilisateur est null
      return Future.error("User is null");
    }
  }



}


