import 'package:flutter/material.dart';
import 'package:popover/popover.dart';


class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>showPopover(
          context: context,
          bodyBuilder: (context)=>Column(
        children: [
          SizedBox(height: 20,),
          Container(child: Center(child: Text('Default')),height: 25,width: 230,decoration: BoxDecoration(color: Colors.brown[100]),),
          SizedBox(height: 15,),
          Container(child: Center(child: Text('Urgent')),height: 25,width: 230,decoration: BoxDecoration(color: Colors.grey),),
          SizedBox(height: 15,),
          Container(child: Center(child: Text('Important')),height: 25,width: 230,decoration: BoxDecoration(color: Colors.grey),),
          SizedBox(height: 15,),
          Container(child: Center(child: Text('Sport')),height: 25,width: 230,decoration: BoxDecoration(color: Colors.grey),),
          SizedBox(height: 15,),
          Container(child: Center(child: Text('Work')),height: 25,width: 230,decoration: BoxDecoration(color: Colors.grey),),
          SizedBox(height: 15,),
          Container(child: Center(child: Text('Study')),height: 25,width: 230,decoration: BoxDecoration(color: Colors.grey),),
          SizedBox(height: 15,),
          Container(child: Center(child: Text('Personal')),height: 25,width: 230,decoration: BoxDecoration(color: Colors.grey),),
        ],),
        height: 350,
        width: 250
      ),
      child: Icon(Icons.menu),
    );
  }
}
