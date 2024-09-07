import 'package:cop_app/acc_comp_screen.dart';
import 'package:cop_app/colors.dart';
import 'package:cop_app/database/save_complaint_db.dart';
import 'package:flutter/material.dart';
import 'package:cop_app/database/database_helper.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'HomeScreen.dart';

class acc_comp_screen extends StatefulWidget {
  const acc_comp_screen({Key? key}) : super(key: key);

  @override
  State<acc_comp_screen> createState() => _acc_comp_screenState();
}

class _acc_comp_screenState extends State<acc_comp_screen> {
  List<Map<String, dynamic>> __complaints2 = [];
  bool _dataFetched = false;

  @override
  void initState() {
    super.initState();
    if (!_dataFetched) {
      _fetch_complaints2();
    }
  }

  Future<void> sending_taken_mail(String userEmail) async {
    try {
      var message = Message()
        ..from = Address('gdmnetwork1@gmail.com')
        ..recipients.add(userEmail)
        ..subject = 'Your Complaint has been solved'
        ..text = '''
        Dear Customer,

        We are pleased to inform you that your complaint has been successfully resolved. Our team has worked diligently to address the issue, and we are happy to confirm that it has been resolved to your satisfaction.

        Thank you for bringing this matter to our attention, and we appreciate your patience throughout the resolution process.

        Best regards,
        [Complaint Pro] 
        ''';

      final smtpServer = gmail('gdmnetwork1@gmail.com', 'cbvh ftlf okix kpds');

      await send(message, smtpServer);
      print('solved Email has been sent');
    } catch (e) {
      print('Failed to send email: $e');
    }
  }

  void _handleVerify(int index) async {
    if (index >= 0 && index < __complaints2.length) {
      Map<String, dynamic> complaint2 = __complaints2[index];
      int rowsAffected =
          await DatabaseHelper2.instance.delete(complaint2['user_name']);
      if (rowsAffected > 0) {
        List<Map<String, dynamic>> updated_complaints2 =
            List.from(__complaints2);
        updated_complaints2.removeAt(index);
        setState(() {
          __complaints2 = updated_complaints2;
        });
      }
    } else {
      print('Invalid index: $index');
    }
  }

  Future<void> _fetch_complaints2() async {
    try {
      List<Map<String, dynamic>> _complaints2 =
          await DatabaseHelper2.instance.queryAll();
      setState(() {
        __complaints2 = _complaints2;
        _dataFetched = true;
      });
    } catch (e) {
      print('Error fetching _complaints2: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accepted complaints'),
      ),
      body: __complaints2.isEmpty
          ? Center(
              child: Text('No complaints found.'),
            )
          : ListView.builder(
              itemCount: __complaints2.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> complaint2 = __complaints2[index];
                String userEmail = complaint2['email'];

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
                          title: Text('User: ${complaint2['user_name']}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email: ${complaint2['email']}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text('Phone Number: ${complaint2['phoneNumber']}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text('Date: ${complaint2['date']}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text('Address: ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('${complaint2['address']}',
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
                                child: Text('${complaint2['paragraph']}',
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
                              icon: Icon(Icons.verified),
                              color: primaryColor,
                              onPressed: () async {
                                sending_taken_mail(userEmail);

                                _handleVerify(index);
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
    );
  }
}
