import 'dart:convert';
import 'package:ESS/global.dart';
import 'package:ESS/models/todoitem.model.dart';
import 'package:http/http.dart' as http;


  const String baseUrl = '${baseurl}todolist/api'; // Adjust the base URL as needed

  Future<Map<String, dynamic>> createTodoItem(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todo'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create ToDo item');
    }
  }

  // Future<List<ToDoItem>> getTodoItems() async {
  //   print("Im in get to do list ");
  //   final response = await http.get(Uri.parse('$baseUrl/todo'));
  //   print("-------------------------------- ");
  //   print(response);
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to load ToDo items');
  //   }
  // }
  Future<List<ToDoItem>> getTodoItems(String employeeId) async {
    print("Fetching ToDo items for employee ID: $employeeId");
    
    // Construct the URL with the employeeId
    final response = await http.get(Uri.parse('$baseUrl/todo/$employeeId'));
    
   

    if (response.statusCode == 200) {
      // Decode the JSON response into a List of ToDoItem objects
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      print("------------GG-------------------- ");
      print(jsonResponse['items'] );
       print("------------GBBB-------------------- ");
      print(jsonResponse['items'] as List<dynamic> );
      final itemSList = jsonResponse['items'] as List<dynamic>? ?? [];
      print("------------GAA1-------------------- ");
      final iList = itemSList.map((item) => ToDoItem.fromJson(item)).toList();
      print("------------GAAA-------------------- ");
      print(iList);
      return iList;
      //return itemSList.map((item) => ToDoItem.fromJson(item)).toList();
    } else if (response.statusCode == 404) {
      throw Exception('No tasks found for this employee.');
    } else {
      throw Exception('Failed to load ToDo items: ${response.reasonPhrase}');
    }
  }
  Future<Map<String, dynamic>> updateTodoItem(String id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('${baseUrl}todo/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update ToDo item');
    }
  }

  Future<void> deleteTodoItem(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/todo/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete ToDo item');
    }
  }

  Future<Map<String, dynamic>> createSubTask(String todoId, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todo/$todoId/subtask'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create SubTask');
    }
  }

  Future<Map<String, dynamic>> updateSubTask(String id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/subtask/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update SubTask');
    }
  }

  Future<void> deleteSubTask(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/subtask/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete SubTask');
    }
  }
