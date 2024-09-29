import 'package:ESS/screens/mangerScreens/ess.home.admin.dart';
import 'package:flutter/material.dart';

class DashBoardAdmin extends StatefulWidget {
  final token;
  
  const DashBoardAdmin({
    super.key,
    this.token,    
  });

  @override
  State<DashBoardAdmin> createState() => _DashBoardAdminState();
}

class _DashBoardAdminState extends State<DashBoardAdmin> {

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

      ESSHomeAdmin(token: widget.token,),
       ESSHomeAdmin(token: widget.token,),
      

      

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
      backgroundColor: Color.fromARGB(255, 242, 242, 242),

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
            icon: Icon(Icons.approval_rounded,color:Color.fromARGB(255, 5, 66, 84)),
            label: 'Requests',
            backgroundColor: Color.fromARGB(255, 253, 255, 255)
          ),
         
          
          
          
        ],
        
        unselectedItemColor: Color(0xFF054254),
        selectedItemColor: Color.fromARGB(255, 5, 66, 84),
        backgroundColor: Colors.white,
      ),
    );
  }
}