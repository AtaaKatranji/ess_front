import 'package:ESS/components/FormHeaderWidget.dart';
import 'package:ESS/models/user.dart';
import 'package:ESS/screens/auth/signin.dart';
import 'package:ESS/apis/api_users.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpScreen extends StatefulWidget {
 
 const SignUpScreen({super.key});
  
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
  String? validatePhoneNumber(String? value) {
  Map<String, int> countryCodeToLength = {
    '+963': 10, // Syria
    '+91': 10, // India
    '+93': 9, // Afghanistan
    // Add more country codes and lengths as needed
  };

  String phoneNumber = value ?? '';
  String countryCode = phoneNumber.substring(0, 4);

  if (countryCodeToLength.containsKey(countryCode)) {
    int requiredLength = countryCodeToLength[countryCode]!;
    if (phoneNumber.length != requiredLength) {
      return 'Invalid phone number length for $countryCode';
    }
  }
  return null;
  }

void navigateToSignIn(BuildContext context) {
    print("Hi");
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignInScreen()),
  );
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();
  User user = User(usreId: "", fullName: "",countryCode: "",phoneNumber: "", password: "",);
  TextEditingController nameController = TextEditingController();
  
  void registerUser()async {
    if(_formKey.currentState!.validate()){
                        print("Ok");
                        var co = user.countryCode;
                        var pho = user.phoneNumber.substring(1);
                        var reqBody = {
                          "name": nameController.text,
                          "phoneNumber": co+pho,
                          "password": user.password
                        };
                        
                        Http.postUser(context,reqBody);
                      }else {
                        print("it's Not ok");
                      }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         backgroundColor: Color.fromARGB(255, 242, 242, 242),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                 // Form header with logo and title
                  FormHeaderWidget(
                    image: 'assets/images/logo.png',
                    title: 'Sign Up',
                    subTitle: 'Create a new account',
                  ),
                  // Sign-up form
                  Column(
      children: [
        // Full name field
        TextFormField(
          controller: nameController,
          onChanged: (value) => {
            user.fullName=value
          },
          validator: (value) {
            if(value!.isEmpty)
              {
                return "Enter a vlaue";
              } else {
                return null;
              }
          },
          decoration: InputDecoration(
            
            labelText: 'Full Name',
            floatingLabelStyle: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(249, 6, 106, 150),),
            prefixIcon: Icon(Icons.person_rounded,color: Color.fromARGB(249, 6, 106, 150),),
            enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(
                color: Color.fromARGB(249, 6, 106, 150)
               )
            ),
            focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(
                color: Color.fromARGB(249, 6, 106, 150)
               )
            ),
          ),
        ),
                // Phone number field
        SizedBox(height: 30,),
       
        IntlPhoneField(
          
          flagsButtonPadding: const EdgeInsets.all(8),
          dropdownIconPosition: IconPosition.trailing,
          controller: TextEditingController(text: user.phoneNumber),
          onChanged: (value) => {
            user.countryCode=value.countryCode,
            user.phoneNumber=value.number
            },
          
          validator: (value) {
              if(value!.completeNumber.isEmpty)
              {
                return "Enter a vlaue";
              } else{
              return null;
              }
            },
          decoration: InputDecoration(
            labelText: 'Phone Number',
            floatingLabelStyle: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(249, 6, 106, 150),),
              prefixIcon: Icon(Icons.phone_android_rounded,color :Color.fromARGB(249, 6, 106, 150),),
            enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(
                color: Color.fromARGB(249, 6, 106, 150)
               )
            ),
            focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(
                color: Color.fromARGB(249, 6, 106, 150)
               )
            ),
          ),
          initialCountryCode: 'SY', // Set the default country code (e.g., 'IN' for India)
        ),
        // Password field
        
        SizedBox(height: 10,),
        TextFormField(
          controller: TextEditingController(text: user.password),
          onChanged: (value) => {
            user.password=value
          },
          validator: (value) {
            if(value!.isEmpty)
              {
                return "Enter a vlaue";
              } else {
                return null;
              }
          },
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            floatingLabelStyle: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(249, 6, 106, 150),),
            prefixIcon: Icon(Icons.password_rounded, color: Color.fromARGB(249, 6, 106, 150),),
            enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(
                color: Color.fromARGB(249, 6, 106, 150)
               )
            ),
            focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(
                color: Color.fromARGB(249, 6, 106, 150)
               )
            ),
          ),
        ),
        SizedBox(height: 20,),
      ],
    ),
                  SizedBox(height: 15,),
                  // Sign-up button
                  ElevatedButton(
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(254, 6, 106, 150),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        
                      )
                      
                       ),
                    onPressed: () {
                      // Handle sign-up logic here
                      registerUser();
                    },
                    child: Text('Sign Up'),
                  ),
                  SizedBox(height: 20,),
                  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have an account!'),
            TextButton(
              onPressed: () {
                // Navigate to the sign-up screen
                 navigateToSignIn(context);
              },
              child: Text(
                'Already Registres?',
                style: TextStyle(
                  
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
  