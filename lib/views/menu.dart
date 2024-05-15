import 'package:flutter/material.dart';
import 'package:to_do_list/views/taskByCategory.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showMenu(context),
      child: Icon(Icons.menu, color: Colors.white, size: 40),
    );
  }

  void showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.symmetric(vertical: 20),
          color: Colors.grey[200],
          child: Column(
            children: [

              buildMenuItem(context, 'Default', Color(0xFFE9C8CE)),
              buildMenuItem(context, 'Urgent', Color(0xFFDEABAF)),
              buildMenuItem(context, 'Important', Color(0xFFDC98BD)),
              buildMenuItem(context, 'Sport', Color(0xFFEBE3F5)),
              buildMenuItem(context, 'Work', Color(0xFFDC98BD)),
              buildMenuItem(context, 'Study', Color(0xFFDEABAF)),
              buildMenuItem(context, 'Personal', Color(0xFFE9C8CE)),
            ],
          ),
        );
      },
    );
  }

  Widget buildMenuItem(BuildContext context, String category, Color color) {
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
        padding: EdgeInsets.symmetric(vertical: 15),
        width: 320,
        decoration: BoxDecoration(
          color: color,
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Center(child: Text(category,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),),
      ),
    );
  }
}
