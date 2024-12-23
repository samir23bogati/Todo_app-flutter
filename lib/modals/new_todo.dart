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
      id:map["_id"],
      title: map["title"],
      description: map["description"],
       );
  }
}