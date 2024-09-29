import 'package:ESS/components/container_1.dart';
import 'package:ESS/components/container_2.dart';
import 'package:ESS/screens/auth/signin.admin.dart';
import 'package:ESS/screens/auth/signin.dart';
import 'package:ESS/screens/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ESSMainPage extends StatefulWidget {
  final token;
  const ESSMainPage({@required this.token, Key? key}) :super(key:key);


  @override
  State<ESSMainPage> createState() => _ESSMainPageState();
}

class _ESSMainPageState extends State<ESSMainPage> {

  void initState() {
    super.initState();
    _checkFirstOpen();
  }

  Future<void> _checkFirstOpen() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstOpen = prefs.getBool('isFirstOpen') ?? true;

      if (isFirstOpen) {
        prefs.setBool('isFirstOpen', false);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 242, 242, 242),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                            flex: 4,
                            child: SmallContainer(
                              mytext: "Attendance menagement",
                               backgroundColor: Colors.orange[50]!,
                               iconBackgroundColor: Colors.white,
                               iconColor: Colors.orange[400]!,
                               icon: Icons.person_rounded, )),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          flex: 6,
                          child: BigContainer(
                            icon: Icons.stacked_line_chart_rounded,
                            iconColor: Colors.purple,
                            toptext: "Incress Your Workflow",
                            bottext: "+200%",
                            backgroundColor: Colors.purple[50]!,
                            boxesColor: Colors.purple[200]!, 
                            size1: 20,
                            size2: 32,
                            size3: 48,
                            size4: 56,)
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                   Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: BigContainer(bottext: "-10.1k", 
                        toptext: "Employee Cost Savings", 
                        icon: Icons.money,
                        iconColor: Colors.green[400]!,
                        backgroundColor: Colors.green[50]!,
                        boxesColor: Colors.green[200]!,
                        size1: 20, size2: 36, size3: 24, size4: 56,)),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        flex: 4, 
                        child: SmallContainer(
                          mytext: "Enhanecd Data accuercy" , 
                          icon: Icons.flash_on_rounded,
                          iconColor: Colors.grey[400]!,
                          iconBackgroundColor: Colors.white,
                          backgroundColor: Colors.indigo[50]!,))
                    ],
                  )),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 42,
                  ),
                  const Text(
                    "Reduce the workloads of HR management.",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                        "Help you to imporve your work efficincy, accuracy, engagement, and cost saving for employers. ",
                        style: TextStyle(
                          height: 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                   InkWell(
                    onTap: ()=>{
                       Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignUpScreen()))
                    },
                     child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      child: const Center(
                        child: Text("I'm a Employee",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                                       ),
                   ),
                   const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: ()=>{
                       Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignInAdminScreen()))
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:  Color.fromARGB(254, 6, 106, 150),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize: const Size(double.infinity, 54),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    child: const Text("I'm a Manger"),
                  ),
                  
                 
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
