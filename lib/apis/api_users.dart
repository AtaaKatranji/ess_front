// ignore_for_file: body_might_complete_normally_nullable, unused_local_variable

import 'dart:convert';
import 'package:ESS/global.dart';
import 'package:ESS/screens/auth/signin.dart';
import 'package:ESS/screens/ess.homePageUser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


// register user 
class Http{
  //register users
  static postUser(BuildContext context, Map reqBody) async {
  try {
    var response = await http.post(
      Uri.parse("${baseurl}api/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    print(response.body);
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse['status']);
    if (jsonResponse['status']) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    } else {
      print("something Went Wrong");
    }
   } catch (e) {
    print('Error: $e');
  }
  }
  }
  //login employee
  Future<void> loginUser(BuildContext context,Map reqBody,SharedPreferences prefs) async {
    final uri = Uri.parse('${baseurl}api/login'); 
    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);
      if(jsonResponse['status']){
        var token = jsonResponse['token'];
        await prefs.setString('token', token);
        await prefs.setBool('isLoggedIn', true);
        Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context)=>HomePageUser(token: token)));
      }else{
        Fluttertoast.showToast(
          msg: "Somthin Went Wrong While Logging In",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Color.fromARGB(161, 250, 1, 1),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }catch(e){
      debugPrint('Erorr In Login API: '+e.toString());
    }
  }



//get employee
  Future<List?> getUser(BuildContext context,SharedPreferences prefs,userId) async {
  final uri = Uri.parse('${baseurl}test/show');
  List? items;
  var reqBody = {
      "userId":userId
    };
  try {
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reqBody)
    );
    var jsonResponse = jsonDecode(response.body);
    
    return items = jsonResponse['success'];
    
  } catch (e) {
    
  }
}

  Future<String?> checkIn(String userId, String checkInTime, String timeZone, String checkDate) async {
  print("IM in check api in front " + userId.toString());

  // Create a map to hold all the parameters to be sent in the body
  Map<String, dynamic> requestBody = {
    'userId': userId, // Assuming userId is a map
    'checkInTime': checkInTime,
    'checkDate': checkDate,
    'timeZone': timeZone
  };

  final response = await http.post(
    Uri.parse('${baseurl}checks/startWork'), // Replace with your API endpoint
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestBody), // Encode the entire map as JSON
  );

  print("after json encode " + response.body);
  var jsonResponse = jsonDecode(response.body);
  print("after json decode " + jsonResponse.toString());

  if (jsonResponse['status']) {
    print('Check-in successful');
    return jsonResponse['data']['checkInTime'];
  } else {
    // Error calling API
    print('Failed to check-in');
    return null;
  }
}


  Future<String?> checkOut(String userId,String checkOutTime, String timeZone, String checkDate) async {
    print("I'm checking out api in front "+userId.toString());
    print(checkOutTime);
    Map<String, dynamic> requestBody = {
    'userId': userId, // Assuming userId is a map
    'checkOutTime': checkOutTime,
    'checkDate': checkDate,
    'timeZone': timeZone

  };

  final response = await http.post(
    Uri.parse('${baseurl}checks/stopWork'), // Replace with your API endpoint
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestBody),
  );

  print("after json encode "+response.body);
  var jsonResponse = jsonDecode(response.body);
  print("after json decode "+jsonResponse.toString());
  if(jsonResponse['status']){
    
    print(jsonResponse['data']['checkOutTime']);
    return jsonResponse['data']['checkOutTime']!;
  } else {
    // Error calling API
    print('Failed to check-out');
  }
}