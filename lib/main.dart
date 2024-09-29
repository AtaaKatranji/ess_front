import 'package:ESS/screens/auth/signin.dart';
import 'package:ESS/screens/ess.main.dart';
import 'package:ESS/screens/ess.homePageUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:timezone/data/latest.dart' as tz_data;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  tz_data.initializeTimeZones();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(ESSApp(token: prefs.getString('token'),));});
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Color.fromARGB(250, 4, 51, 101)
    ..indicatorColor = Colors.yellow
    ..textColor = Color(0xFF054254)
    ..maskColor = Colors.blue
    ..userInteractions = true
    ..dismissOnTap = true
    ..toastPosition = EasyLoadingToastPosition.top;
    
    
}

class ESSApp extends StatelessWidget {
  final token;
  const ESSApp({@required this.token, Key? key}) :super(key:key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dividerColor: Colors.transparent,
      ),
      builder: EasyLoading.init(),
      home: FutureBuilder(future:  _getInitialScreen(token),builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return snapshot.data!;
        },),
      //home:(token != null && JwtDecoder.isExpired(token) == false )? DashBoardAdmin(token: token):ESSMainPage(token: token)
      //home: (token != null && JwtDecoder.isExpired(token) == false )? Test(token: token):ESSMainPage(token: token),
      //initialRoute: '/',
      // routes: {
      //   '/': (context) => ESSMainPage(token: token), // Your home screen
      //   '/login': (context) => SignInScreen(), // Your login screen
      //   // Add other routes as needed
      // },
    );
  }
}
  Future<Widget> _getInitialScreen(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isFirstLaunch) {
      // Set isFirstLaunch to false after the first launch
      
      await prefs.setBool('isFirstLaunch', false);
      print(isFirstLaunch);
      return ESSMainPage(token: token);
    } else if (isLoggedIn) {
      return HomePageUser(token: token);
    } else {
      return SignInScreen();
    }
  }


class InitialScreen extends StatelessWidget {
  final token;

  InitialScreen({this.token});

  @override
  Widget build(BuildContext context) {
    // Check if the token is valid
    if (token != null && !JwtDecoder.isExpired(token)) {
      // Navigate to the dashboard if the token is valid
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      });
    } else {
      // Navigate to the ESS Main Page if the token is invalid
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/ess');
      });
    }

    // Show a loading indicator while navigating
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}