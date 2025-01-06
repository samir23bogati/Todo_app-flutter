import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modals/new_todo.dart';
import 'package:ulid/ulid.dart';

class DatabaseService {
  Database? _dbInstance;

  final String _dbName = "todo.db";
  final String _tableName = "notes";

  Future<Database> get dbInstance async {
    if (_dbInstance == null) {
      final dbPath = await getDatabasesPath();
      _dbInstance = await openDatabase(
        "$dbPath/$_dbName",
        version: 3, // incrementedd to trigger the upgrade
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE $_tableName (id TEXT PRIMARY KEY, title TEXT,description TEXT, created_at INTEGER, sync INTEGER DEFAULT 1)');
        },
        onUpgrade: (db, oldVersion, newVersion)async {
          if(oldVersion < 3){
           try {
              await db.execute("ALTER TABLE $_tableName ADD COLUMN sync INTEGER DEFAULT 1");
            } catch (e) {
              print("Error during schema upgrade: $e");
            } }
        },
      );
    }
    return _dbInstance!;
   
  }

  Future<List<Todo>> fetchTodos() async {
    final instance = await dbInstance;
    final resp = await instance.query(_tableName);
    List<Todo> todo = resp.map((e) => Todo.fromDBMap(e)).toList();
    return todo;
  }

  Future<Todo> addTodo(Todo todo) async {
    final instance = await dbInstance;
    final Map<String, dynamic> mapData = {
      "id": todo.id.isNotEmpty ? todo.id : "${Ulid().toUuid()}",
      "title": todo.title,
      "description": todo.description,
      "created_at": DateTime.now().millisecondsSinceEpoch,
      "sync": todo.id.isNotEmpty ? 1 : 0,
    };
    await instance.insert(_tableName, mapData);

    return Todo.fromDBMap(mapData);
  }

  Future<Todo> updateTodo(Todo todo,{required bool isOffline}) async {
    final instance = await dbInstance;
    final Map<String, dynamic> mapData = {
      "title": todo.title,
      "description": todo.description,
      "sync":isOffline ? 0 : 1,
    };
    await instance
        .update(_tableName, mapData, where: "id = ?", whereArgs: [todo.id]);
    return todo;
  }

  Future<void> deleteTodo(String id) async {
    final instance = await dbInstance;
    await instance.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteAllTodo() async {
    final instance = await dbInstance;
    await instance.delete(_tableName);
  }
   Future<bool> get existAnyNotSyncronizedData async {
    final instance = await dbInstance;
    try {
      final res = await instance.query(_tableName, where: "sync = ?", whereArgs: [0]);
      return res.isNotEmpty;
    } catch (e) {
      print("Error checking unsynced data: $e");
      return false; 
    }
  }
     Future<List<Todo>> get notSyncedTodos async {
    final instance = await dbInstance;
    try {
      final res = await instance.query(_tableName, where: "sync = ?", whereArgs: [0]);
      return res.map((e) => Todo.fromDBMap(e)).toList();
    } catch (e) {
      print("Error fetching unsynced todos: $e");
      return []; 
    }
     }
}
