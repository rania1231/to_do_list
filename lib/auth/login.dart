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
      UserCredential userCredential = (await _auth.signInWithEmailAndPassword(userEmail, userPassword)) as UserCredential;
      User? user = userCredential.user;
      if (user != null) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
        print("User logged in successfully");
      } else {
        print("Error: User is null");
      }
    } catch (e) {
      print("Error signing in: $e");
    }
  }
}
