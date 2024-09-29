import 'package:ESS/screens/Maintinace.dart';
import 'package:ESS/screens/ess.home.dart';
import 'package:ESS/screens/ess.history.dart';
import 'package:flutter/material.dart';

class HomePageUser extends StatefulWidget {
  final token;
  const HomePageUser({super.key,this.token});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {

    int _selectedIndex = 0;
    late List<Widget> _pages;
    void initState() {
      super.initState();
      _pages = [
        ESSHome(token: widget.token,),
        ESSHistory(token: widget.token,),
        QRScannerScreen(),
      ];
    }
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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