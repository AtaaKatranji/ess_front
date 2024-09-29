import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;

  FormHeaderWidget({
    required this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Image.asset(
          image,
          width: 100,
          height: 100,
        ),
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}