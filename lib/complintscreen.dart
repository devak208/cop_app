import 'package:cop_app/acc_comp_screen.dart';
import 'package:cop_app/colors.dart';
import 'package:cop_app/database/save_complaint_db.dart';
import 'package:flutter/material.dart';
import 'package:cop_app/database/database_helper.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ComplaintListScreen extends StatefulWidget {
  const ComplaintListScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintListScreen> createState() => _ComplaintListScreenState();
}

class _ComplaintListScreenState extends State<ComplaintListScreen> {
  List<Map<String, dynamic>> _complaints = [];
  bool _dataFetched = false;

  @override
  void initState() {
    super.initState();
    _fetchComplaints();
  }

  Future<void> sending_taken_mail(String userEmail) async {
    try {
      var message = Message()
        ..from = Address('gdmnetwork1@gmail.com')
        ..recipients.add(userEmail)
        ..subject = 'Your Complaint has been accepted'
        ..text = '''
        Dear Customer,

        Your complaint has been taken. We are actively working on resolving this issue and will keep you updated on the progress.

        Thank you for bringing this matter to our attention.

        Best regards,
        [Complaint pro]
        ''';

      final smtpServer = gmail('gdmnetwork1@gmail.com', 'cbvh ftlf okix kpds');

      await send(message, smtpServer);
      print('Accept Email has been sent');
    } catch (e) {
      print('Failed to send email: $e');
    }
  }

  void _handleVerify(int index) async {
    if (index >= 0 && index < _complaints.length) {
      Map<String, dynamic> complaint = _complaints[index];
      int rowsAffected =
          await DatabaseHelper.instance.delete(complaint['user_name']);
      if (rowsAffected > 0) {
        List<Map<String, dynamic>> updatedComplaints = List.from(_complaints);
        updatedComplaints.removeAt(index);
        setState(() {
          _complaints = updatedComplaints;
        });
      }
    } else {
      print('Invalid index: $index');
    }
  }

  Future<void> _saveComplaint(Map<String, dynamic> complaint) async {
    try {
      await DatabaseHelper2.instance.insert(complaint);
      print("Complaint saved successfully.");
    } catch (e) {
      print('Failed to save complaint: $e');
    }
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
        title: Text('Complaints List'),
      ),
      body: _complaints.isEmpty
          ? Center(
              child: Text('No complaints found.'),
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
                          title: Text('User: ${complaint['user_name']}',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.archive_rounded),
                              color: primaryColor,
                              onPressed: () async {
                                _handleVerify(index);
                                sending_taken_mail(userEmail);
                                _saveComplaint(complaint);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: primaryColor,
                              onPressed: () {
                                _handleVerify(index);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 750),
        child: IconButton(
          icon: Icon(Icons.archive_rounded),
          color: primaryColor,
          iconSize: 32,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => acc_comp_screen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
