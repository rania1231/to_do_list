import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../views/home.dart';
import 'auth_methods.dart';




class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  FirebaseAuthentificationServices _auth= FirebaseAuthentificationServices();
  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();

    super.dispose();
  }


  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body:Column(
        children: [
          Container(height: 20),

          Text("Email", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
          Container(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            validator: (val){
              if(val== ""){
                return "Can't be empty";
              }
            },
            controller: email,
            decoration: InputDecoration(
                hintText: 'Enter your email', hintStyle:   TextStyle(color: Colors.grey[400]),
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
          Text("Password", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
          Container(height: 20),
          TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            validator: (val){
              if(val== ""){
                return "Can't be empty";
              }
            },
            controller: password,
            decoration: InputDecoration(
                hintText: 'Enter your password', hintStyle:   TextStyle(color: Colors.grey[400]),
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

          SizedBox( height:20),
          ElevatedButton(
            child:Text('Login'),
              onPressed: ()async{

    try {
      await signIn();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),(route)=>false
      );
    }catch(e){
      print("error in login");
    }




    }
              ,
          )
        ],
      )
    );
  }
  Future<void> signIn() async {
    String userEmail = email.text;
    String userPassword = password.text;

    try {
      final userCredential = await signInWithEmailAndPassword(userEmail, userPassword);
      if (userCredential != null) {
        // Navigate to your home page or handle successful sign-in
        print('Signed in successfully!');
      }
    } catch (e) {
      print("Error signing in: $e");
    }
  }
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e.code); // Print other errors
      }
    }
    return null;
  }
}
