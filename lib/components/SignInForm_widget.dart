import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

  String? validatePhoneNumber(String? value) {
  Map<String, int> countryCodeToLength = {
    '+963': 13, // Singapore
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
class SignInFormWidget extends StatelessWidget {

  final Function(String) onPhoneNumberChanged;
  final Function(String) onPasswordChanged;

  SignInFormWidget({
    required this.onPhoneNumberChanged,
    required this.onPasswordChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       IntlPhoneField(
          onChanged: (phoneNumber) {
            var co = phoneNumber.countryCode;
            var fo = phoneNumber.number.substring(1);
            onPhoneNumberChanged(co+fo);
          },
          flagsButtonPadding: const EdgeInsets.all(8),
          dropdownIconPosition: IconPosition.trailing,
          // controller: TextEditingController(text: user.phoneNumber),
          // onChanged: (value) => {
          //   user.phoneNumber=value as String
          // },
          // validator: (value) {
          //     if(value!.isValidNumber())
          //     {
          //       return "Enter a vlaue";
          //     } else{
          //       if (validatePhoneNumber(value as String?) != null) {
          //       return 'Invalid phone number';
          //     }
          //     return null;
          //     }
          //   },
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
        SizedBox(height: 20,),
        TextFormField(
          onChanged: onPasswordChanged,
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
    );
  }
}