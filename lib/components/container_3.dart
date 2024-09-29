import 'package:flutter/material.dart';

class meduimContainer extends StatelessWidget {

  final Color backgroundColor;
  final String mytext ;
  final String bodytext ;
  final String footertext ;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  //final VoidCallback onPressed;

  

 
  const meduimContainer({super.key, 
  required this.mytext, 
  this.bodytext = "10:00 am",
  this.footertext = "On time",
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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: iconBackgroundColor,
                    
                    
                  ),
                  
                  
                  child: Icon(icon , color: iconColor,),
                ),
                const SizedBox(
                  width: 8,
                ),
                
                  Text(
                  mytext,
                  style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
                
               
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
              Text(
                
              bodytext,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            )
            ],),
            SizedBox(height: 10,),
            Row(children: [
              Text(
              footertext,
              style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
            )
            ],)
          
          ],
        ),
      ),
    );
  }
}
