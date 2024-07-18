import 'package:data/db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  var titController=TextEditingController();
  var decController=TextEditingController();
  List<Map<String,dynamic>> mda=[];
  var mTime=DateFormat.Hm();
  AppData? db;
  @override
  void initState() {
    super.initState();
    db=AppData.db;
    getNotes();
  }

  void getNotes()async{
   mda=await db!.fecNotes();
   setState(() {

   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DataBase Project'),
        backgroundColor: Colors.blue,
      ),
      body: mda.isNotEmpty?ListView.builder(
        itemCount: mda.length,
        itemBuilder: (context, index) =>
          ListTile(
            title: Text(mda[index]['title'],style: TextStyle(fontSize: 20),),
            subtitle: Text(mda[index]['desc'],style: TextStyle(fontSize: 20)),
          ),):
      Container(child: Center(
        child: Text('No Notes Yet...'),
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          titController.clear();
          decController.clear();
          showModalBottomSheet(context: context, builder: (context) => mySheet(),);

        },child: Icon(Icons.add),
      ),
    );
  }
  Widget mySheet(){
    return Container(
        height: 700,
        decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
    ),
    child: Padding(
    padding: EdgeInsets.all(15),
    child: Column(children: [
    Text('Notes',style: TextStyle(fontSize: 30),),
    TextField(controller: titController,
    decoration: InputDecoration(
      label: Text('Enter Title'),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20)
    )
    ),),
    SizedBox(height: 10,),
    TextField(controller: decController,
    decoration: InputDecoration(
        label: Text('Enter Subtitle'),
        border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    )
    ),),
    SizedBox(height: 10,),
    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
    ElevatedButton(onPressed: (){
      db!.addNote(title: titController.text, desc: decController.text,);
      getNotes();
    Navigator.pop(context);
    }, child: Text('Add',style: TextStyle(fontSize: 25),)),
        ElevatedButton(onPressed: (){
        Navigator.pop(context);
        }, child: Text('Cancel',style: TextStyle(fontSize: 25),)),
      ],
    ),
  ])));

  }
}

