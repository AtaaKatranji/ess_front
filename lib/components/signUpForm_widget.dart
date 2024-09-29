import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpFormWidget extends StatelessWidget {
  final Function(String) onPhoneNumberChanged;
   SignUpFormWidget({
    required this.onPhoneNumberChanged,
   
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Full name field
        TextFormField(
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
        SizedBox(height: 20,),
        IntlPhoneField(
          onChanged: (phoneNumber) {
            onPhoneNumberChanged(phoneNumber.completeNumber);
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
        // TextFormField(
        //   decoration: InputDecoration(
        //     labelText: 'Phone Number',
        //     floatingLabelStyle: TextStyle(
        //       fontSize: 18,
        //       color: Color.fromARGB(249, 6, 106, 150),),
        //       prefixIcon: Icon(Icons.phone_android_rounded,color :Color.fromARGB(249, 6, 106, 150),),
        //     enabledBorder: OutlineInputBorder(
        //        borderRadius: BorderRadius.circular(10),
        //        borderSide: BorderSide(
        //         color: Color.fromARGB(249, 6, 106, 150)
        //        )
        //     ),
        //     focusedBorder: OutlineInputBorder(
        //        borderRadius: BorderRadius.circular(10),
        //        borderSide: BorderSide(
        //         color: Color.fromARGB(249, 6, 106, 150)
        //        )
        //     ),
        //   ),
        // ),
        // Password field
        SizedBox(height: 20,),
        TextFormField(
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