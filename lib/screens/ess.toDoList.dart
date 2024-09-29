// ignore_for_file: deprecated_member_use

import 'package:ESS/apis/api_todo.dart';
import 'package:flutter/material.dart';
import 'package:ESS/models/todoitem.model.dart';

class ToDoList extends StatefulWidget {
  final String? userId;
  
 ToDoList({
    super.key,
    this.userId,    
  });
  _ToDoListState createState() => _ToDoListState();
  
}


class _ToDoListState extends State<ToDoList> with TickerProviderStateMixin {
  List<ToDoItem> _todoItems = [];
  
  String? get userId => widget.userId;
  //List<ToDoItem> _items = [
  //   ToDoItem(
  //     title: 'Task 1',
  //     description: 'Description 1',
  //     priority: 1,
  //     subTasks: [
  //       SubTask(description: 'Subtask 1.1'),
  //       SubTask(description: 'Subtask 1.2'),
  //       SubTask(description: 'Subtask 1.3'),
  //     ],
  //   ),
  //   ToDoItem(
  //     title: 'Task 2',
  //     description: 'Description 2',
  //     priority: 2,
  //     subTasks: [
  //       SubTask(description: 'Subtask 2.1'),
  //       SubTask(description: 'Subtask 2.2'),
  //       SubTask(description: 'Subtask 2.3'),
  //     ],
  //   ),
  //   ToDoItem(
  //     title: 'Task 3',
  //     description: 'Description 3',
  //     priority: 3,
  //     subTasks: [
  //       SubTask(description: 'Subtask 3.1'),
  //       SubTask(description: 'Subtask 3.2'),
  //       SubTask(description: 'Subtask 3.3'),
  //     ],
  //   ),
  // ];

  Future<void> fetchTasksByEmployeeId(String userId) async {
    try {
      print("fetchTasksByEmployeeId");
      // Call the API to fetch tasks for the specified employee
      List<ToDoItem> tasks = await getTodoItems(userId);
      print("444444 $tasks");
      setState(() {
        _todoItems = tasks;
      });
    } catch (e) {
      // Handle any errors that may occur during the API call
      print('Error fetching tasks for employee IDDDDDDDDDDDD $userId: $e');
    }
  }
  void _onCheckChanged(ToDoItem item, bool? value) {
    if(item.isChecked != value){
    setState(() {
       item.isChecked = value!;
      if (item.isChecked) {
        // ignore: unused_local_variable
        int oldIndex = _todoItems.indexOf(item);
        _todoItems.remove(item);
        _todoItems.add(item);

        // Use an animation to smoothly move the checked item to the bottom
        AnimationController controller = AnimationController(
          duration: const Duration(milliseconds: 300),
          vsync: this,
        );
        controller.forward();

        AnimatedList(
          key: ValueKey(item.title),
          initialItemCount: _todoItems.length,
          itemBuilder: (context, index, animation) {
            return _buildItem(context, _todoItems[index], animation);
          },
        );
      }
    });
    }
  }

  void _onSubTaskCheckChanged(ToDoItem item, SubTask subTask, bool? value) {
    setState(() {
      subTask.isChecked = value!;
    });
  }

  double _calculateProgress(ToDoItem item) {
    if (item.subTasks?.isEmpty ?? true)  {
      return 0;
    }
  
       final completedSubTasks = item.subTasks?.where((subTask) => subTask.isChecked).length ?? 0;
       final totalSubTasks = item.subTasks?.length ?? 0;
return completedSubTasks / totalSubTasks;
  }
  //void fetchTodoItems() async {
  //   try {
  //     print("Im in fetch to do list ");
  //     final items = await api.getTodoItems();
  //     print(items);
  //     setState(() {
  //       _todoItems = items;
  //     });
  //   } catch (e) {
  //     // Handle error
  //   }
  // }

    @override
  void initState() {
    super.initState();
    //fetchTodoItems();
    fetchTasksByEmployeeId(userId!);
  }


  @override
  Widget build(BuildContext context) {
    return  _todoItems.isEmpty
      ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/no_tasks.png', // Replace with your image path
                  width: 200, height: 200),
              SizedBox(height: 16),
              Text('No tasks found',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        )
      :ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final ToDoItem item = _todoItems.removeAt(oldIndex);
          _todoItems.insert(newIndex, item);
        });
      },
      children: _todoItems.map((item) {
        return 
          Container(
            key: ValueKey(item.title),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: item.isChecked ? Colors.green[50] : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ExpansionTile(
                  title: Text(item.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.description),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: item.isChecked,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return Color.fromARGB(255, 4, 92, 124); // Color when checkbox is checked
                            }
                            return Color.fromARGB(255, 255, 255, 255); // Color when checkbox is unchecked
                          },
                        ),
                        onChanged: (bool? value) {
                          _onCheckChanged(item, value);
                        },
                      ),
                      Text('Priority: ${item.priority}'),
                    ],
                  ),
                  children: item.subTasks!.map((subTask) {
                    return ListTile(
                      title: Text(subTask.description),
                      leading: Checkbox(
                        value: subTask.isChecked,
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.grey[300]; // Color when checkbox is checked
                            }
                            return Colors.grey[200]; // Color when checkbox is unchecked
                          },
                        ),
                        onChanged: (bool? value) {
                          _onSubTaskCheckChanged(item, subTask, value);
                        },
                      ),
                    );
                  }).toList(),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                  child: LinearProgressIndicator(
                    value: _calculateProgress(item),
                    valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 0, 117, 143)),
                    backgroundColor: Colors.grey,
                  ),
                ),
              ],
            ),
          
        );
      }).toList(),
    );
  }

  Widget _buildItem(BuildContext context, ToDoItem item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        key: ValueKey(item.title),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: item.isChecked ? Colors.grey[300] : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            ExpansionTile(
              title: Text(item.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.description),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: item.isChecked,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Color.fromARGB(255, 4, 92, 124); // Color when checkbox is checked
                        }
                        return Color.fromARGB(255, 255, 255, 255); // Color when checkbox is unchecked
                      },
                    ),
                    onChanged: (bool? value) {
                      _onCheckChanged(item, value);
                    },
                  ),
                  Text('Priority: ${item.priority}'),
                ],
              ),
              children: item.subTasks?.map((subTask)  {
                return ListTile(
                  title: Text(subTask.description),
                  leading: Checkbox(
                    value: subTask.isChecked,
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.grey[300]; // Color when checkbox is checked
                        }
                        return Colors.grey[200]; // Color when checkbox is unchecked
                      },
                    ),
                    onChanged: (bool? value) {
                      _onSubTaskCheckChanged(item, subTask, value);
                    },
                  ),
                );
              }).toList() ?? [],
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
              child: LinearProgressIndicator(
                value: _calculateProgress(item),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
