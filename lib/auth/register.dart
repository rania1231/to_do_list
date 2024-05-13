import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/auth/login.dart';
import 'package:to_do_list/classes/FirestoreService.dart';

import '../views/home.dart';
import 'auth_methods.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  FirebaseAuthentificationServices _auth= FirebaseAuthentificationServices();


  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    name.dispose();

    super.dispose();
  }

  TextEditingController name =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: ListView(
          children: [
            Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 10),

                    // Center(child: Text("Sign Up", style: TextStyle(fontSize:50, fontWeight:  FontWeight.bold),)),

                    Text("Username", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                    Container(height: 20),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: false,
                validator: (val){
                                if(val== ""){
                                  return "Can't be empty";
                                }
                },
                controller: name,
                decoration: InputDecoration(
                    hintText: 'Enter your username', hintStyle:   TextStyle(color: Colors.grey[400]),
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

                    Container(height: 40,),
                    ElevatedButton(onPressed: ()async{
                      await signUp();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
                    }, child: Text('Register'))
                  ]),
            )
          ],
        ),
      ),
    );
  }


  Future<User?>signUp() async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email.text,
    password: password.text,
  );
    FirestoreService firestoreService=FirestoreService();
    await firestoreService.addUser(credential, name.text, email.text, password.text);


  }


}
