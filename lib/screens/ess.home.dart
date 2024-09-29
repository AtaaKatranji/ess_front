// ignore_for_file: unused_field
import 'package:ESS/utils/WifiValidator.dart';
import 'package:ESS/components/container_3.dart';
import 'package:ESS/screens/ess.profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ESS/apis/api_users.dart' as api;
import 'package:ESS/apis/api_checksInOut.dart' as apiChecks;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:ESS/screens/ess.toDoList.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ESSHome extends StatefulWidget {
  final token;

  ESSHome({super.key,this.token,});

  @override
  State<ESSHome> createState() => _ESSHomeState();
}

class _ESSHomeState extends State<ESSHome> {
  late Map<String, dynamic> decodedToken;
  late String welcomeMessage;
  late Icon welcomeIcon;
  late String userId;
  late String name;
  late String phoneNumber;
  late String timeIn = "--/--";
  late String timeOut = "--/--";
  late String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late String currentOutDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late String total = "0";
  late String profileImageUrl= " ";
  late String _localTime;
  late String _timeZoneName;

  @override
  void initState() {
    super.initState();
    _extractUserInfo();
    _welcome();
    _checkedOut();
    _checkedIn();
    _resetChecked();
    _getUserLocalTime();
   // _totalHours(); // Call _totalHours when the page loads
  }

  void _getUserLocalTime() {
    // Get the current time
    DateTime now = DateTime.now();
    
    // Format the date and time for the user's locale
    String formattedTime = DateFormat('hh:mm a').format(now);
    
    // Get the time zone name
    String timeZoneName = now.timeZoneName;
    
    setState(() {
      _localTime = formattedTime;
      _timeZoneName = timeZoneName;
    });
  }

  Future _resetChecked() async {
  final prefs = await SharedPreferences.getInstance();
  String? storedDate = prefs.getString('currentDate');
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  if (storedDate == null || storedDate != currentDate) {
    // Reset timeIn to its initial value
    prefs.remove("InProvider"); // Remove old check-in time
    prefs.remove("Out"); // Remove old check-Out time
    setState(() {
      timeIn = "--/--"; // Reset timeIn to its initial value
      timeOut = "--/--"; // Reset timeIn to its initial value
    });
  }
}

  Future<void> _totalHours() async {
    DateTime now = DateTime.now();
    String month = DateFormat('MMMM').format(now);
    String year = DateFormat('yyyy').format(now);
    try {
      var t = await apiChecks.totalHours(userId, month, year);
      print(t);
      setState(() {
        total = t!;
      });
      
    } catch (e) {
      throw e;
    }
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

  Future<void> _checkedIn() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      timeIn = prefs.getString('InProvider')!;
    });
  }

  Future<void> _checkedOut() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      timeOut = prefs.getString('Out')!;
    });
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

  void onCheckInPressed(userId) async {
  WifiValidator wifiValidator = WifiValidator();
  bool isConnectedToWork = await wifiValidator.isConnectedToWorkWifi();

  if (isConnectedToWork) {
    // Proceed with check-in or check-out
    debugPrint("Connected to work Wi-Fi. Proceeding with check-in/out.");
    checkIn(userId);
  } else {
    // Show an error message
    debugPrint("You must be connected to the work Wi-Fi to check in or out.");
    Fluttertoast.showToast(
      msg: "You must be connected to the work Wi-Fi to check in or out.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.deepPurple,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

  void onCheckOutPressed(userId) async {
  WifiValidator wifiValidator = WifiValidator();
  bool isConnectedToWork = await wifiValidator.isConnectedToWorkWifi();

  if (isConnectedToWork) {
    // Proceed with check-in or check-out
    print("Connected to work Wi-Fi. Proceeding with check-in/out.");
    checkOut(userId);
  } else {
    // Show an error message
    print("You must be connected to the work Wi-Fi to check in or out.");
    Fluttertoast.showToast(
      msg: "You must be connected to the work Wi-Fi to check in or out.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.deepPurple,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

  Future<void> checkIn(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  String? storedDate = prefs.getString('currentDate');
  // Get the current time and time zone
  DateTime now = DateTime.now();
  String formattedTime = DateFormat('hh:mm a').format(now);
  String checkDate  = DateFormat('yyyy-MM-dd').format(now);
  String timeZoneName = now.timeZoneName;

  // Check if the user has already checked in today
  if (storedDate == null || storedDate != currentDate) {
    print("Checking in...");
    /*
    Send check-in request with local time and time zone
    Assuming userId is a String      
    Pass the check-in time and Date
    Pass the time zone
    */
    var time = await api.checkIn(userId,formattedTime,timeZoneName,checkDate,);    

    print("time when checjed in = "+time!);
    
    // Store the time and date in shared preferences
    await prefs.setString('InProvider', time);
    await prefs.setString('currentDate', currentDate);

    setState(() {
      timeIn = prefs.getString('InProvider')!;
    });

    Fluttertoast.showToast(
      msg: "You have checked in successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } else {
    print("You already checked in today");
    Fluttertoast.showToast(
      msg: "You already checked in today",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Color.fromARGB(162, 1, 130, 250),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

  Future<void> checkOut(String userId) async {
  print("Checking out...");
  final prefs = await SharedPreferences.getInstance();
  String? storedDate = prefs.getString('currentOutDate');

  // Get the current time and time zone
  DateTime now = DateTime.now();
  String formattedTime = DateFormat('hh:mm a').format(now);
  String checkDate = DateFormat('yyyy-MM-dd ').format(now);
  String timeZoneName = now.timeZoneName;
  print(formattedTime);
  // Check if the user has already checked out today
  if (storedDate == null || storedDate != currentOutDate) {
    // Send check-out request with local time and time zone
    var timeout = await api.checkOut(
      userId,
      formattedTime,
      timeZoneName,
      checkDate,
    );

    print("Check-out time: " + timeout.toString());

    // Store the time and date in shared preferences
    var outtime = await prefs.setString('Out', timeout!);
    await prefs.setString('currentOutDate', currentOutDate);

    setState(() {
      if (outtime) {
        timeOut = prefs.getString('Out')!;
      } else {
        print("Check-out process failed");
      }
      print("Check-out time in setState: " + timeout.toString());
    });
  } else {
    print("You already checked out today");
    Fluttertoast.showToast(
      msg: "You already checked out today",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Color.fromARGB(162, 250, 1, 130),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

  @override
  Widget build(BuildContext context) {
    
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM-dd-yyyy').format(now);
    String month = DateFormat('MMMM').format(now);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String fullMessage = "Mr.$name";
    String displayedMessage = fullMessage;

    if (fullMessage.length > 20) {
      displayedMessage = fullMessage.substring(0, 16) + '...';
    }
    return Scaffold(
            backgroundColor: Color.fromARGB(255, 242, 242, 242),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenWidth * 0.04,
          ),
          child: Column(
            children: [
              // First small section
              Flexible(
                flex: 1,
                child: Container(
                  //color: Colors.blue,
                  // Add your content here
                  child: Container(               
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      welcomeIcon,
                                      SizedBox(width: screenWidth * 0.01,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //welcome Message
                                          Text(
                                            "$welcomeMessage$displayedMessage",
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.045,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF054254)
                                            ),
                                          ),
                                          //Date
                                          Text(
                                            formattedDate,
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.035,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF054254)
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (_) => ProfileScreen(
                                  //     name: name,
                                  //     phoneNumber: phoneNumber,
                                  //   ),
                                  // ));
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProfileScreen(
                                                            name: name,
                                                            phoneNumber: phoneNumber,
                                                          ),),
                                );
                                },
                                child: Container(
                                  width: screenWidth * 0.12,
                                  height: screenWidth * 0.12,
                                  decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color.fromARGB(255, 82, 223, 255), Color.fromARGB(232, 7, 121, 147)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                                  color: Color(0xFF054254), // Border color
                                                  width: 2.0, // Width of the border
                                                ),),
                                  child: CircleAvatar(
                                    backgroundImage:  AssetImage('assets/images/avatar1.png'),
                                    backgroundColor: Colors.transparent,
                                    //backgroundImage: NetworkImage(profileImageUrl),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              
              // Second small section
              Flexible(
                flex: 2,
                child: Container(
                  //color: Colors.green,
                  // Add your content here
                  child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: screenHeight * 0.16,
                                  width: screenWidth * 0.44,
                                  child: InkWell(
                                    onTap: () {
                                      onCheckInPressed(userId);
                                    },
                                    child: meduimContainer(
                                      mytext: "Check In",
                                      bodytext: timeIn,
                                      icon: Icons.arrow_forward,
                                      iconColor: Colors.green[200]!,
                                      iconBackgroundColor: Colors.green[50]!,
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.03),
                                Container(
                                  
                                  height: screenHeight * 0.16,
                                  width: screenWidth * 0.44,
                                  child: InkWell(
                                    onTap: () {
                                      onCheckOutPressed(userId);
                                      
                                    },
                                    child: meduimContainer(
                                      mytext: "Check Out",
                                      bodytext: timeOut,
                                      icon: Icons.arrow_back,
                                      iconColor: Colors.red[200]!,
                                      iconBackgroundColor: Colors.red[50]!,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                ),
              ),
              
              // Big middle section
              Flexible(
                flex: 5,
                child: Container(
                  //color: Colors.red,
                  // Add your content here
                  child: ToDoList(userId:userId),
                ),
              ),
              
              // Third small section
              Flexible(
                flex: 1,
                child: Container(
                  //color: Colors.yellow,
                  // Add your content here
                  child: Container(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                          width: screenWidth,
                          height: screenHeight * 0.1,  // Adjust the height as needed
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: InkWell(
                                    onTap: () {
                                      print("Ui total hours "+userId);
                                      _totalHours();
                                    },
                                    child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total hours for $month:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold , 
                                        fontSize: 17,
                                        color: Color(0xFF054254)
                                        ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                    total,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF054254)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),)
                        ),
                      
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
