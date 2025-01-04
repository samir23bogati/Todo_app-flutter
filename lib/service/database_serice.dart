import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modals/new_todo.dart';
import 'package:ulid/ulid.dart';

class DatabaseService{

  Database? _dbInstance;

  final String _dbName = "todo.db";
  final String _tableName = "notes";

  Future<Database> get dbInstance async {
    if (_dbInstance == null){
      final dbPath =await getDatabasesPath();
      _dbInstance = await openDatabase(
        "$dbPath/$_dbName",
          version: 1,
          onCreate: (db, version)async {
       await db.execute(
 'CREATE TABLE $_tableName (id TEXT PRIMARY KEY, title TEXT, description TEXT,created_at INTEGER)'
       );
          },
          );
        
    }
    return _dbInstance!;
  }
  Future<List<Todo>>fetchTodos()async{
    final instance = await dbInstance;
    final resp = await instance.query(_tableName);
    List<Todo> todo = resp.map((e) => Todo.fromDBMap(e)).toList();
    return todo;
  }
 Future<Todo> addTodo(Todo todo )async{
     final instance = await dbInstance;
    final Map<String,dynamic> mapData = {
      "id": todo.id.isNotEmpty ? todo.id :"local_${Ulid().toUuid()}",
      "title": todo.title,
      "description": todo.description,
      "created_at":DateTime.now().millisecondsSinceEpoch,
    };
    await instance.insert(_tableName,mapData);

    return Todo.fromDBMap(mapData);
 }
 Future<Todo> updateTodo(Todo todo )async{
   final instance = await dbInstance;
   final Map<String,dynamic> mapData = {
      "title": todo.title,
      "description": todo.description,
      
    };
     await instance.update(_tableName,mapData,where: "id = ?", whereArgs: [todo.id]);
    return todo;
 }
  Future<void> deleteTodo(String id )async{
     final instance = await dbInstance;
     await instance.delete(_tableName,where:"id = ?", whereArgs: [id]);
  }
  Future<void>deleteAllTodo()async{
    final instance = await dbInstance;
    await instance.delete(_tableName);
  }
}