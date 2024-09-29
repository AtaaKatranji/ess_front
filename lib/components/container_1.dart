import 'package:flutter/material.dart';

class SmallContainer extends StatelessWidget {

  final Color backgroundColor;
  final String mytext ;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  //final VoidCallback onPressed;

  

 
  const SmallContainer({super.key, 
  required this.mytext, 
  this.backgroundColor = Colors.white ,
  this.iconColor =  Colors.black,
  this.iconBackgroundColor = Colors.green, 
  this.icon = Icons.abc, });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child:  Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: iconBackgroundColor,
                
                
              ),
              
              
              child: Stack(
                alignment: Alignment.center,
                children: [
                
                Icon(icon , color: iconColor,),
              ],)
            ),
            const SizedBox(
              height: 16,
            ),
            
              Text(
              mytext,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
