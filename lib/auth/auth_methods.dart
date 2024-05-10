import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthentificationServices{
    FirebaseAuth _auth=FirebaseAuth.instance;
    Future<User?> signUpWithEmailAndPassword(String email , String password)async{
        try{
          UserCredential credential=await _auth.createUserWithEmailAndPassword(email: email, password: password) ;
          return credential.user;
        }catch(e){
          print("Eror during creating the account. Please try another time");
        }
    }

    Future<User?> signInWithEmailAndPassword(String email , String password)async{
      try{
        UserCredential credential=await _auth.signInWithEmailAndPassword(email: email, password: password) ;
        return credential.user;
      }catch(e){
        print("Eror during the Login. Please try another time");
      }
    }

}
