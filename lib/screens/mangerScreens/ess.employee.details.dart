import 'package:ESS/apis/api_todo.dart';
import 'package:flutter/material.dart';
import 'package:ESS/models/user.dart';
import 'package:ESS/apis/api_todo.dart' as api;

import 'package:ESS/models/todoitem.model.dart';

List<User> employees = [
  User(usreId: '669272cf3784386de1a710f2', fullName: 'Alice',countryCode: "+963",phoneNumber: "0936499499",password: "12345678" ),
  User(usreId: '2', fullName: 'Bob',countryCode: "+963",phoneNumber: "0936499488",password: "12345679" ),
];
List<ToDoItem> tasks = [];
// List<ToDoItem> tasks = [
//     ToDoItem(
//       id: 1,
//       title: 'Task 1',
//       description: 'Description 1',
//       employeeId: "1",
//       priority: 1,
//       subTasks: [
//         SubTask(title: 'Subtask 1.1', toDoItemId: 1),
//         SubTask(title: 'Subtask 1.2',toDoItemId: 1),
//         SubTask(title: 'Subtask 1.3',toDoItemId: 1),
//       ],
//     ),
//     ToDoItem(
//       id: 3,
//       title: 'Task 2',
//       description: 'Description 2',
//       employeeId: "1",
//       priority: 2,
//       subTasks: [
//         SubTask(title: 'Subtask 2.1',toDoItemId: 2),
//         SubTask(title: 'Subtask 2.2',toDoItemId: 2),
//         SubTask(title: 'Subtask 2.3',toDoItemId: 2),
//       ],
//     ),
//     ToDoItem(
//       id: 2,
//       title: 'Task 3',
//       description: 'Description 3',
//       employeeId: "1",
//       priority: 3,
//       subTasks: [
//         SubTask(title: 'Subtask 3.1',toDoItemId: 3),
//         SubTask(title: 'Subtask 3.2',toDoItemId: 3),
//         SubTask(title: 'Subtask 3.3',toDoItemId: 3),
//       ],
//     ),
//   ];


// List<ToDoItem> getTasksByEmployeeId(String employeeId) {
//   return tasks.where((task) => task.employeeId == employeeId).toList();
// }
class EmployeeDetailPage extends StatefulWidget {
  final User employee;

  EmployeeDetailPage({required this.employee});

  @override
  _EmployeeDetailPageState createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
  List<ToDoItem> employeeTasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasksByEmployeeId(widget.employee.usreId);
  }

  Future<void> fetchTasksByEmployeeId(String employeeId) async {
    try {
      print("Fk");
      // Call the API to fetch tasks for the specified employee
      List<ToDoItem> tasks = await getTodoItems(employeeId);
      print("444444 $tasks");
      setState(() {
        employeeTasks = tasks;
      });
    } catch (e) {
      // Handle any errors that may occur during the API call
      print('Error fetching tasks for employee IDDDDDDDDDDDD $employeeId: $e');
    }
  }

  void addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTaskTitle = '';
        String newTaskDescription = '';
        int newTaskPriority = 0;
        List<SubTask> newSubTasks = [];

        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  newTaskTitle = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter task title',
                ),
              ),
              TextField(
                onChanged: (value) {
                  newTaskDescription = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter description',
                ),
              ),
              TextField(
                onChanged: (value) {
                  newTaskPriority = int.tryParse(value) ?? 0;
                },
                decoration: InputDecoration(
                  hintText: 'Enter task priority',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (newTaskTitle.isNotEmpty) {
                  // Prepare the data to be sent to the server
                  ToDoItem newTask = ToDoItem(
                    title: newTaskTitle,
                    description: newTaskDescription,
                    employeeId: widget.employee.usreId,
                    priority: newTaskPriority,
                    subTasks: newSubTasks,
                  );

                  try {
                    // Call the createTodoItem function
                    ToDoItem createdTask = (await createTodoItem(newTask as Map<String, dynamic>)) as ToDoItem;

                    // Update the local state
                    setState(() {
                      employeeTasks.add(createdTask);
                    });

                    Navigator.of(context).pop();
                  } catch (e) {
                    // Handle error (e.g., show a Snackbar or AlertDialog)
                    print('Error creating task: $e');
                  }
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void updateTask(ToDoItem task) {
    // Implement update task functionality
  }

   void deleteTask(String taskId) async {
    try {
      await api.deleteTodoItem(taskId); // Call the delete API function
      setState(() {
        employeeTasks.removeWhere((task) => task.id == taskId);
      });
    } catch (e) {
      print('Error deleting task: $e');
      // Optionally, show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        title: Text('Employee Details: ${widget.employee.fullName}'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenWidth * 0.04,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: employeeTasks.length,
                  itemBuilder: (context, index) {
                    final task = employeeTasks[index];
                    return ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: task.isChecked,
                            onChanged: (value) {
                              setState(() {
                                task.isChecked = value ?? false;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              updateTask(task);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteTask(task.id!);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: screenWidth * 0.13,
                    height: screenHeight * 0.06,
                    child: ElevatedButton(
                      onPressed: addTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 5, 50, 84),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Icon(
                        Icons.add_circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}