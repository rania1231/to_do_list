import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:to_do_list/views/taskByCategory.dart';


class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>showPopover(
          context: context,
          bodyBuilder: (context)=>Column(
            children: [
              SizedBox(height: 10),
              buildMenuItem(context, 'Default'),
              buildMenuItem(context, 'Urgent'),
              buildMenuItem(context, 'Important'),
              buildMenuItem(context, 'Sport'),
              buildMenuItem(context, 'Work'),
              buildMenuItem(context, 'Study'),
              buildMenuItem(context, 'Personal'),

            ],
        ),
        height: 450,
        width: 250
      ),
      child: Icon(Icons.menu),
    );
  }
  Widget buildMenuItem(BuildContext context, String category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryTasksPage(category: category),
          ),
        );
      },
      child: Container(
        child: Center(child: Text(category)),
        height: 25,
        width: 230,
        decoration: BoxDecoration(color: Colors.grey),
        // Add styling as needed
        margin: EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }
}
