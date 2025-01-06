class Todo{
  final String title;
  final String description;
  final String id;

  Todo({
    required this.id,
  required this.description,
  required this.title,
  });

  factory Todo.fromMap(Map<String,dynamic> map){
    return Todo(
      id:map["_id"] ,
      title: map["title"],
      description: map["description"],
       );
  }
  factory Todo.fromLocalMap(Map<String,dynamic> map){
    return Todo(
      id:"" ,
      title: map["title"],
      description: map["description"],
       );
  }
   factory Todo.fromDBMap(Map<String,dynamic> map){
    return Todo(
      id:map["id"] ,
      title: map["title"],
      description: map["description"],
       );
  }
  Map<String,dynamic> toMap(){
    final Map<String,dynamic> temp = {
      "title":title,
      "description":description,
    };

    return temp;

  }
  Map<String,dynamic> toMapId(){
    final Map<String,dynamic> temp = {
      "_id":id,
      "title":title,
      "description":description,
    };

    return temp;

  }
  Todo copyWith({
    String? id,
    String? title,
    String? description,
  }){
    return Todo(
      id: id ?? this.id,
      title: title?? this.title,
      description: description ?? this.description,
    );
  }
}