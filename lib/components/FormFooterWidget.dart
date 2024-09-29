import 'package:ESS/screens/auth/signup.dart';
import 'package:flutter/material.dart';

class SignInFooterWidget extends StatelessWidget {

    void navigateToSignUp(BuildContext context) {
    print("Hi");
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignUpScreen()),
  );
}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Forgot password?',
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Don\'t have an account?'),
            TextButton(
              onPressed: () {
                // Navigate to the sign-up screen
                 navigateToSignUp(context);
              },
              child: Text(
                'Create a new account',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}