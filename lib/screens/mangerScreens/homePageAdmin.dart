import 'package:ESS/screens/ess.home.dart';
import 'package:ESS/screens/ess.history.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  final token;
  
  const Test({
    super.key,
    this.token,    
  });

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

    int _currentIndex = 0;
    late List<Widget> _children;
    final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

    void initState() {
    super.initState();

    _children = [
      ESSHome(token: widget.token,),
      ESSHistory(token: widget.token,),
      

      

    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    }
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      body:Stack(
        children: _children.asMap().map((index, screen) {
          return MapEntry(
            index,
            Offstage(
              offstage: _currentIndex != index,
              child: Navigator(
                key: _navigatorKeys[index],
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (context) => screen,
                  );
                },
              ),
            ),
          );
        }).values.toList(),
      ),

      bottomNavigationBar: BottomNavigationBar(
        
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color:Color.fromARGB(255, 5, 66, 84)),
            label: 'Home',
            backgroundColor: Colors.white
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month,color:Color.fromARGB(255, 5, 66, 84)),
            label: 'Schedual',
            backgroundColor: Color.fromARGB(255, 253, 255, 255)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code,color: Color.fromARGB(255, 5, 66, 84)),
            label: 'Scan',
            backgroundColor: Color.fromARGB(255, 255, 255, 255)
          ),
          
          
          
        ],
        
        unselectedItemColor: Color(0xFF054254),
        selectedItemColor: Color.fromARGB(255, 5, 66, 84),
        backgroundColor: Colors.white,
      ),
    );
  }
}