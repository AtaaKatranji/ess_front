import 'package:flutter/material.dart';

class BigContainer extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color boxesColor;
  final String toptext ;
  final String bottext ;
  final double size1 ;
  final double size2 ;
  final double size3 ;
  final double size4 ;
  //final VoidCallback onPressed;

  

 
  const BigContainer({super.key, 
  required this.toptext,
  required this.bottext, 
  required this.icon,
  this.iconColor = Colors.white,
  this.backgroundColor = Colors.grey,
  this.boxesColor = Colors.black,
  this.size1 = 4,
  this.size2 = 6,
  this.size3 = 8,
  this.size4 = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child: Padding(
        padding:EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon( icon,color: iconColor,),
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
              toptext,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(bottext, style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54
                ),),
                Spacer(),
                Container(
                  width: 8,
                  height: size1,
                  margin: EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: boxesColor,
                  ),
                ),
                Container(
                  width: 8,
                  height: size2,
                  margin: EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: boxesColor,
                  ),
                ),
                Container(
                  width: 8,
                  height: size3,
                  margin: EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: boxesColor,
                  ),
                ),
                Container(
                  width: 8,
                  height: size4,
                  margin: EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: boxesColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
