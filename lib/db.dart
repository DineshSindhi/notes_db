import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppData{

  AppData._();

  static final AppData db=AppData._();

  Database? myDb;
  Future<Database> getDb()async{
    if(myDb!=null){
      return myDb!;
    }else{
      myDb=await initDb();
      return myDb!;
    }
  }
  Future<Database> initDb()async{
    var root =await getApplicationDocumentsDirectory();
    var mainRoot=join(root.path,'noteDb.db');
    return await openDatabase(mainRoot,version: 1,onCreate: (db,version){
      db.execute('create table note ( note_id integer primary key autoincrement , title text,desc text,) ');
    });
  }

  void addNote({required String title,required String desc,})async{
   var nt= await getDb();
   nt.insert('note', {
     'title':title,
     'desc':desc,

   });
  }

  Future<List<Map<String,dynamic>>> fecNotes()async{
    var db=await getDb();
    var data=await db.query('note');
    return data;
  }

}