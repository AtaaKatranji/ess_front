import 'package:flutter/material.dart';
//import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ESS/components/FormFooterWidget.dart';
import 'package:ESS/components/FormHeaderWidget.dart';
import 'package:ESS/components/SignInForm_widget.dart';
import 'package:ESS/apis/api_users.dart' as api;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences prefs;
  //final LocalAuthentication auth = LocalAuthentication();
  //bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    initSharedPref();
    // checkBiometrics();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Future<void> checkBiometrics() async {
  //   bool canCheckBiometrics = false;
  //   try {
  //     canCheckBiometrics = await auth.canCheckBiometrics;
  //   } catch (e) {
  //     canCheckBiometrics = false;
  //   }

  //   if (!mounted) return;

  //   setState(() {
  //    / _isBiometricAvailable = canCheckBiometrics;
  //   });
  // }

  Future<void> signInUser(String phoneNumber, String password) async {
    if (phoneNumber.isNotEmpty && password.isNotEmpty) {
      var reqBody = {
        "phoneNumber": phoneNumber,
        "password": password,
      };
      print(reqBody);
      final String response = await api.loginUser(context, reqBody, prefs).toString();
      if (response.isNotEmpty) {
        print("Do it : "+response);
        //prefs.setBool('isBiometricSetup', true);
      }
    } else {
      print("errrrrrrrror");
    }
  }

  // Future<void> authenticateWithBiometrics() async {
  //   bool authenticated = false;
  //   try {
  //     authenticated = await auth.authenticate(
  //       localizedReason: 'Authenticate to access your account',
  //       options: AuthenticationOptions(
  //         useErrorDialogs: true,
  //         stickyAuth: true,
  //       ),
  //     );
  //   } catch (e) {
  //     print(e);
  //   }

  //   if (authenticated) {
  //     // Handle successful biometric authentication here
  //     print("Biometric authentication successful");
  //   } else {
  //     print("Biometric authentication failed");
  //   }
  // }

  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormHeaderWidget(
                    image: 'assets/images/logo.png',
                    title: 'Sign In',
                    subTitle: 'Welcome back!',
                  ),
                  SignInFormWidget(
                    onPhoneNumberChanged: (value) {
                      setState(() {
                        _phoneNumber = value;
                      });
                    },
                    onPasswordChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(254, 6, 106, 150),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await signInUser(_phoneNumber, _password);
                      // if (prefs.getBool('isBiometricSetup') ?? false) {
                      //   authenticateWithBiometrics();
                      // }
                    },
                    child: Text('Sign In'),
                  ),
                 
                  SignInFooterWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
