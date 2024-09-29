import 'package:flutter/material.dart';

Widget customToast({required String message, required IconData icon}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 12.0),
        Text(message, style: const TextStyle(color: Colors.white)),
      ],
    ),
  );
}