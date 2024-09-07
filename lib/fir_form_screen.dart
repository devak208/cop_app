import 'package:cop_app/acc_comp_screen.dart';
import 'package:cop_app/colors.dart';
import 'package:cop_app/database/save_complaint_db.dart';
import 'package:flutter/material.dart';
import 'package:cop_app/database/database_helper.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

class FirFormScreen extends StatefulWidget {
  const FirFormScreen({super.key});

  @override
  State<FirFormScreen> createState() => _FirFormScreenState();
}

class _FirFormScreenState extends State<FirFormScreen> {
  List<Map<String, dynamic>> _complaints = [];
  bool _dataFetched = false;

  @override
  void initState() {
    super.initState();
    _fetchComplaints();
  }

  Future<void> _fetchComplaints() async {
    try {
      List<Map<String, dynamic>> complaints =
          await DatabaseHelper.instance.queryAll();
      setState(() {
        _complaints = complaints;
        _dataFetched = true;
      });
    } catch (e) {
      print('Error fetching complaints: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Complaints'),
      ),
      body: _complaints.isEmpty
          ? Center(
              child: Text('No complaints registered'),
            )
          : ListView.builder(
              itemCount: _complaints.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> complaint = _complaints[index];
                String userEmail = complaint['email'];

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text('Name: ${complaint['user_name']}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email: ${complaint['email']}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text('Phone Number: ${complaint['phoneNumber']}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text('Date: ${complaint['date']}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text('Address: ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('${complaint['address']}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Text('About the complaint: ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('${complaint['paragraph']}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
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
    );
  }
}
