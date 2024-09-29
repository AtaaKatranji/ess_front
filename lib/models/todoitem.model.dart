
class ToDoItem {
  String? id; 
  String title;
  String description;
  bool isChecked;
  int priority;
  String employeeId;
  List<SubTask>? subTasks;
  ToDoItem({
    this.id,
    required this.title,
    required this.description,
    required this.employeeId,
    this.isChecked = false,
    required this.priority,
    this.subTasks,
  });
  factory ToDoItem.fromJson(Map<String, dynamic> json) {
    return ToDoItem(
       id: json['_id'],
      employeeId: json['employeeId'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      subTasks: (json['subTasks'] as List<dynamic>?)
          ?.map((subTaskJson) => SubTask.fromJson(subTaskJson))
          .toList(),
    );
  }
}

class SubTask {
  String? id; 
  String description;
  bool isChecked;
  String toDoItemId;
SubTask({
  this.id,
  required this.description,
  required this.toDoItemId,
  this.isChecked = false,
});
factory SubTask.fromJson(Map<String, dynamic> json) {
    return SubTask(
      id: json['_id'] as String?, // Allow id to be null
      toDoItemId: json['toDoItem'] as String? ?? '', // Provide a default value
      description: json['description'] as String? ?? '', // Provide a default value
    );
  }
}
