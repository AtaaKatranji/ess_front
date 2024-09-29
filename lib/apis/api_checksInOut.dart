import 'dart:async';
import 'package:ESS/global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = baseurl;

//API Fetch Checks
Future<List<Map<String, String>>> fetchCheckInOutHistory(userId, range) async {
  print("in fetchCheckInOutHistory: \n");

  var response ; 
  switch (range) {
    
    case 'This Month':
     response = await http.post(
        Uri.parse('${url}checks/monthlyHistory'), //  API endpoint to return checks this month
        body:  {"employeeId":userId},
        );
    case 'Last Month':
     response = await http.post(
        Uri.parse('${url}checks/lastmonthlyHistory'), //  API endpoint to return checks Last Month
        body:  {"employeeId":userId},
        );
    case 'All':
      response = await http.post(
        Uri.parse('${url}checks/api/history'), //  API endpoint to return All checks  
        body:  {"employeeId":userId},
        );
      
      break;

  }

  if (response.statusCode == 200 ) {
    final data = jsonDecode(response.body);
    final history = data['tempA']! as List<dynamic> ;
    return history.map((entry) {
      return {
        'checkInTime': entry['checkInTime'].toString(),
        'checkOutTime': entry['checkOutTime'].toString(),
        'date': entry['checkDate'].toString().split('T')[0],
      };
    }).toList();
  } else {
    throw Exception('Failed to load history');
  }
}
//API Calculate Total Hours
Future<String?> totalHours(userId , month, year) async {
  print(userId);
  print(month+year);
  final response = await http.post(
        Uri.parse('${url}checks/api/calculate-hours'), // Replace with your API endpoint
        body:  {"userId":userId, "month":month, "year":year},
        );
        print(response.body);
        print("--------------");
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data);
    final total = data['total']['totalHours'];
    print(total);
    return total;
    }else{
      return "no hours";
    }
}