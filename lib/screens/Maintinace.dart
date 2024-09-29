import 'package:flutter/material.dart';


class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
 
  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
  bool _isLoading = false;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        title: Row(children: [Text('QR Scanning' ,style: TextStyle(
                                fontWeight: FontWeight.bold , 
                                fontSize: 20,
                                color: Color(0xFF054254)
                                ),),
                                Spacer(),
                                InkWell(
                                  onTap: (){} ,
                                  child: Icon(
         Icons.refresh,
          color: Color.fromARGB(255, 24, 154, 229),
          size: 24.0,
        ),)],),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        leading: null,
      ),
      body: _isLoading
          // ignore: dead_code
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.developer_mode,
                  color: Color.fromARGB(255, 53, 129, 184),
                  size: 56.0,),
                  Text("This Page under maintaince")
                ],
              )
            ],
          )
    );
  }
}