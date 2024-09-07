import 'dart:io';
import 'dart:core';

import 'package:cop_app/complintscreen.dart';
import 'package:cop_app/database/database_helper.dart';

import 'package:flutter/material.dart';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'colors.dart';
import 'package:image_picker/image_picker.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:mailer/smtp_server.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final user_name = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final phoneNumber = TextEditingController();
  final date = TextEditingController();
  final paragraph = TextEditingController();
  late final String Latitude;
  late final String Longitude;

  bool complaintSubmitted = false;
  bool _validater = true;
  bool _validatename = false;
  bool _validateemail = false;
  bool _validateaddress = false;
  bool _validatephonenumber = false;
  bool _validatedate = false;
  bool _validateparagraph = false;

  File? image;
  bool locationSelected = false;
  bool imageUploaded = false;

  Future<void> _getImage() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        print(image);
        imageUploaded = true;
      });
    }
  }

  Future<void> getLocationPermissionAndRetrieveLocation() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        print(
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
        setState(() {
          locationSelected = true;
          Latitude = position.latitude.toString() as String;
          Longitude = position.longitude.toString() as String;
        });
      } catch (e) {
        print('Error getting location: $e');
      }
    } else {
      print('Location permission denied');
    }
  }

  Future<void> sendingmail() async {
    try {
      var userEmail = 'gdmnetwork1@gmail.com';
      var message = Message()
        ..from = Address(userEmail)
        ..recipients.add('devakdevak208@gmail.com')
        ..subject = 'Complaint'
        ..text =
            'New complaint\n\nName: ${user_name.text} \n\nEmail: ${email.text}\n\nPhoneNumber: ${phoneNumber.text}\n\nDate: ${date.text}\n\nAddress: ${address.text}\n\nLocation: Latitude-${Latitude} Longitude-${Longitude} \n\nAbout the complaint:\n ${paragraph.text}'
        ..attachments = [FileAttachment(File(image!.path))];

      final smtpServer = gmail(userEmail, 'cbvh ftlf okix kpds');

      await send(message, smtpServer);
      print('Email has been sent');
    } catch (e) {
      print('Failed to send email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 100, bottom: 20),
                    child: Container(
                        child: Text(
                          "  Register Your Complaint ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              primaryColor.withOpacity(0.3),
                              primaryColor.withOpacity(0.0),
                              Colors.transparent,
                            ]),
                            border: Border(
                                left: BorderSide(
                                    color: primaryColor, width: 4)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: user_name,
                      decoration: InputDecoration(
                          labelText: 'Name',
                          errorText:
                              _validatename ? 'value can\'t be empty' : null,
                          labelStyle:
                              TextStyle(color: primaryColor, fontSize: 17),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          errorText:
                              _validateemail ? 'value can\'t be empty' : null,
                          labelStyle:
                              TextStyle(color: primaryColor, fontSize: 17),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneNumber,
                        decoration: InputDecoration(
                            labelText: 'Phone Number',
                            errorText: _validatephonenumber
                                ? 'value can\'t be empty'
                                : null,
                            labelStyle:
                                TextStyle(color: primaryColor, fontSize: 17),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 25.0, bottom: 15),
                    child: TextFormField(
                        keyboardType: TextInputType.datetime,
                        controller: date,
                        decoration: InputDecoration(
                            labelText: 'Date',
                            errorText:
                                _validatedate ? 'value can\'t be empty' : null,
                            labelStyle:
                                TextStyle(color: primaryColor, fontSize: 17),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)))),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Enter Address:',
                              style:
                                  TextStyle(color: primaryColor, fontSize: 17),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: address,
                              keyboardType: TextInputType.text,
                              maxLines: 5,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: primaryColor)),
                              ),
                            ),
                          ])),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Enter your Complaint:',
                              style:
                                  TextStyle(color: primaryColor, fontSize: 17),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: paragraph,
                              keyboardType: TextInputType.text,
                              maxLines: 5,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: primaryColor)),
                              ),
                            ),
                          ])),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 200),
                          child: locationSelected
                              ? ElevatedButton.icon(
                                  key: UniqueKey(),
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Location Selected",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            primaryColor),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(150, 30)),
                                  ),
                                )
                              : ElevatedButton.icon(
                                  key: UniqueKey(),
                                  onPressed:
                                      getLocationPermissionAndRetrieveLocation,
                                  icon: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Select Location",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            primaryColor),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(150, 30)), // Set a fixed width
                                  ),
                                ),
                        ),
                        SizedBox(
                            width: 10), // Add some space between the buttons
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 200),
                          child: imageUploaded
                              ? ElevatedButton.icon(
                                  key: UniqueKey(),
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Image Uploaded",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            primaryColor),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(150, 30)),
                                  ),
                                )
                              : ElevatedButton.icon(
                                  key: UniqueKey(),
                                  onPressed: _getImage,
                                  icon: Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Upload Picture",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            primaryColor),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(150, 30)), // Set a fixed width
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: .0, left: 35, right: .0, bottom: 30),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          int i = await DatabaseHelper.instance.insert({
                            DatabaseHelper.columnuser_name: user_name.text,
                            DatabaseHelper.columnemail: email.text,
                            DatabaseHelper.columnphoneNumber: phoneNumber.text,
                            DatabaseHelper.columndate: date.text,
                            DatabaseHelper.columnaddress: address.text,
                            DatabaseHelper.columnparagraph: paragraph.text,
                          });
                          print("The New inserted data is: $i");

                          if (!complaintSubmitted) {
                            sendingmail();
                            complaintSubmitted = true;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Complaint submitted!',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: primaryColor,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Complaint already submitted!',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: primaryColor,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        } else {
                          print("Invalid login details");
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        size: 35,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Submit Complaint",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryColor),
                        minimumSize: MaterialStateProperty.all(Size(300, 60)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
