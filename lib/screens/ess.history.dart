// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:ESS/apis/api_checksInOut.dart' as api;

class ESSHistory extends StatefulWidget {
  final String token;

  ESSHistory({super.key, required this.token});

  @override
  _ESSHistoryState createState() => _ESSHistoryState();
}

class _ESSHistoryState extends State<ESSHistory> {
  late Map<String, dynamic> decodedToken;
  late String userId;
  List<Map<String, String>> checkInOutHistory = [];
  bool _isLoading = false;
  String selectedFilter = 'This Month'; // Default filter option

  @override
  void initState() {
    super.initState();
    _extractUserInfo();
    if (userId != null) {
    _loadHistory(userId, selectedFilter);
  } else {
   Fluttertoast.showToast(
      msg: "No ID.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Color.fromARGB(255, 255, 109, 109),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  }

  void _extractUserInfo() {
    if (widget.token.isNotEmpty) {
      try {
        print(widget.token);
        decodedToken = JwtDecoder.decode(widget.token);
        setState(() {
          userId = decodedToken['_id'];
          print(userId);
        });
      } catch (e) {
        print('Error decoding token: $e');
      }
    } else {
      print("Token is Null");
    }
  }

  Future<void> _loadHistory(String userId, String filter) async {
    setState(() {
      _isLoading = true;
    });
    final List<Map<String, String>> history;
    if (filter == 'All') {
      history = await api.fetchCheckInOutHistory(userId,'All');
    } else if (filter == 'This Month') {
      history = await api.fetchCheckInOutHistory(userId,'This Month');
    } else if (filter == 'Last Month') {
      history = await api.fetchCheckInOutHistory(userId,'Last Month');
    } else {
      history = "No checks" as List<Map<String, String>>;
    }
    setState(() {
      checkInOutHistory = history.map((entry) {
        return {
          'checkIn': entry['checkInTime'].toString(),
          'checkOut': entry['checkOutTime'].toString(),
          'date': entry['date'].toString(),
        };
      }).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'History',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF054254)),
            ),
            Spacer(),
            InkWell(
              onTap: () async {
                await _loadHistory(userId, selectedFilter);
              },
              child: Icon(
                Icons.refresh,
                color: Color.fromARGB(255, 24, 154, 229),
                size: 24.0,
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        leading: null,
      ),
      body: Column(
        children: [
          // Dropdown filter widget
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Filter: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF054254),
                  ),
                ),
                DropdownButton<String>(
                  value: selectedFilter,
                  items: ['This Month', 'Last Month','All',]
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFilter = newValue!;
                    });
                    _loadHistory(userId, selectedFilter);
                  },
                ),
              ],
            ),
          ),
          // History list view
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: checkInOutHistory.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          subtitle: Text(
                            checkInOutHistory[index]["date"].toString(),
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Check-In: ${checkInOutHistory[index]['checkIn']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Check-Out: ${checkInOutHistory[index]['checkOut']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
