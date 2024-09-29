// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:ESS/global.dart';
import 'package:ESS/screens/mangerScreens/ess.dashboard.admin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String url = baseurl;

  Future<void> loginAdmin(BuildContext context,Map reqBody,SharedPreferences prefs) async {
  print("Hi from login Admin");
  final uri = Uri.parse('${baseurl}test/login');
  
  try {
    print('im in loginAdmin ${uri}');
    
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reqBody)
      
    );
    print("I'm in api in front"+response.toString());
    var jsonResponse = jsonDecode(response.body);
    if(jsonResponse['status']){
      var token = jsonResponse['token'];
      prefs.setString('token', token);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardAdmin(token: token)));
    }else{
      print("Somthin Went Wrong While Logging In");
    }
}catch(e){
  print('Erorr In: '+e.toString());
}
}
