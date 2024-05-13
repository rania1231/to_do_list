import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController taskName=TextEditingController();
  TextEditingController taskDate=TextEditingController();
  List<String> categories=['Default','Urgent'];
  String dropdownValue = 'Default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task', style: TextStyle(fontWeight: FontWeight.bold),)),
      body: Container(
        child: Column(
          children: [
            Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 10),

                    // Center(child: Text("Sign Up", style: TextStyle(fontSize:50, fontWeight:  FontWeight.bold),)),

                    Text("What to be done?", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                    Container(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      validator: (val){
                        if(val== ""){
                          return "Can't be empty";
                        }
                      },
                      controller: taskName,
                      decoration: InputDecoration(
                          hintText: 'Enter Task Here', hintStyle:   TextStyle(color: Colors.grey[400]),
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

                    Text("Due date", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                    Container(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.datetime,
                      obscureText: false,
                      controller: taskDate,
                      decoration: InputDecoration(
                          hintText: 'No date set', hintStyle:   TextStyle(color: Colors.grey[400]),
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

                    Text("Categorie", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                    Container(height: 20),
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: dropdownValue,
                          items: categories.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),

                          onChanged:  (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },),
                        IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.add))
                      ],
                    )
                  ]),
            )
          ],
        ),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){},
        child: Icon(CupertinoIcons.check_mark),
      ) ,
    );
  }
}
