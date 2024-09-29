import 'package:ESS/screens/mangerScreens/ess.employee.details.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';



class ESSHomeAdmin extends StatefulWidget {
  final token;

  ESSHomeAdmin({
    super.key,
    this.token,
  });

  @override
  State<ESSHomeAdmin> createState() => _ESSHomeAdminState();
}

class _ESSHomeAdminState extends State<ESSHomeAdmin> {
  late Map<String, dynamic> decodedToken;
  late String welcomeMessage;
  late Icon welcomeIcon;
  late String userId;
  late String name;
  late String phoneNumber;
  late String profileImageUrl= " ";
  

  @override
  void initState() {
    super.initState();
    _extractUserInfo();
    _welcome();

  }
  
  
  Future<void> _welcome() async {
    var now  = new DateTime.now();
     if (now.hour < 12) {
      welcomeMessage = "Morning, ";
      welcomeIcon = Icon(
         Icons.wb_sunny,
          color: Colors.yellow,
          size: 48.0,
        ); // Sun icon for morning
    } else {
      welcomeMessage = "Evening, ";
      welcomeIcon = Icon(
          Icons.nights_stay,
          color: Color.fromARGB(255, 163, 217, 255),
          size: 48.0,
        ); // Moon icon for evening
    }
  }

  void _extractUserInfo() {
    if (widget.token != null) {
      try {
        print(widget.token);
        decodedToken = JwtDecoder.decode(widget.token);
        setState(() {
          userId = decodedToken['_id'];
          name = decodedToken['name'];
          phoneNumber = decodedToken['phoneNumber'];
        });
        print("$userId $name $phoneNumber");
      } catch (e) {
        print('Error decoding token: $e');
      }
    } else {
      print("Token is Null");
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
        title: Text('Admin Home'),
      ),
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.04,
            horizontal: screenWidth * 0.04,
          ),
          child: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Add space between items
      child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: ListTile(
              title: Text(employee.fullName),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeeDetailPage(employee: employee),
                  ),
                );
              },
            ),
          ),);
        },
      ),
    ),
      ));
  }
}
