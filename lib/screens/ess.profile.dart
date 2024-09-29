import 'package:ESS/screens/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final String profileImageUrl;
  final String name;
  final String phoneNumber;
  final String address;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.phoneNumber,
    this.profileImageUrl = '',
    this.address = '',
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
 Future<void> _signOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    // Remove the token or any user data
    await prefs.remove('token'); 
    await prefs.remove('InProvider'); 
    await prefs.remove('Out');
    await prefs.remove('isLoggedIn');
    await prefs.remove('currentDate');
    await prefs.remove('currentOutDate');

    // Show a toast message
    // Fluttertoast.showToast(
    //   msg: "You have signed out successfully",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.TOP,
    //   backgroundColor: Colors.green,
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    // );
    

    // Navigate back to the login screen or main screen
  //   Navigator.pushAndRemoveUntil(
  //   context,
  //   MaterialPageRoute(builder: (context) => SignInScreen()),
  //   (Route<dynamic> route) => false,
  // );
   // Adjust the route as needed
    // Navigator.push(
    // context,
    // MaterialPageRoute(builder: (context) => SignInScreen()));
  }

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(
                                fontWeight: FontWeight.bold , 
                                fontSize: 20,
                                color: Color(0xFF054254)
                                ),),
          backgroundColor: Color.fromARGB(255, 242, 242, 242),  // Customize the AppBar color
          iconTheme: IconThemeData(color: Color(0xFF054254),), // Color for the back arrow
           titleSpacing: -10.0,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration( 
                  color: Color.fromARGB(120, 86, 196, 251), 
                  borderRadius: BorderRadius.circular(16), 
                  image: DecorationImage(
                    image:  AssetImage('assets/images/background_profile_image2.png'), 
                    fit: BoxFit.cover, // Cover the entire container
                    ),
                ),
                width: double.infinity, // Set to full width of the screen (or use specific width)
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration( 
                  color: Color.fromARGB(0, 86, 196, 251), 
                  borderRadius: BorderRadius.circular(20),),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 110, // The width of the container should be slightly larger than the CircleAvatar
                            height: 110, // The height of the container should be slightly larger than the CircleAvatar
                            decoration: BoxDecoration(
                            shape: BoxShape.circle, // Ensures the border is circular
                            border: Border.all(
                                color: const Color.fromARGB(255, 255, 255, 255), // Border color
                                width: 2.0, // Width of the border
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/images/avatar1.png'), // user image
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //user name
                            Text(
                              widget.name,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            //user phone number
                            Text(
                              widget.phoneNumber,
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                      ),           
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Edit Profile Button
            // ElevatedButton.icon(
            //   onPressed: () {
            //     // Add edit profile functionality here
            //   },
            //   icon: Icon(Icons.edit),
            //   label: Text('Edit Profile'),
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: Colors.white, backgroundColor: Colors.teal, // Text color
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //   ),
            // ),
            // 
            SizedBox(height: 32),
            //(List of settings)
            /*
              ListTile(
              leading: Icon(Icons.settings, color: Colors.teal),
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings screen
              },
            ),
             */
            ListTile(
              leading: Icon(Icons.lock, color: Color.fromARGB(255, 59, 190, 255),),
              title: Text('Change Password'),
              onTap: () {
                // Navigate to change password screen
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Log Out'),
              onTap: () {
                // Add logout functionality
                _signOut(context);
                // Show a toast message
                Fluttertoast.showToast(
                  msg: "You have signed out successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                // Navigate back to the login screen or main screen
                Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
                (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}