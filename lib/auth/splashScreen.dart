import 'package:flutter/material.dart';
import 'package:to_do_list/auth/login.dart';
import 'package:to_do_list/auth/register.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 3),
        (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Register()) , (route) => false);
        }


    ) ;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welecome to To Do List'),
      ),
    );
  }
}
