import 'dart:math';

import 'package:cop_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'colors.dart';
import 'LoginScreen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  late String _email, _password, _repassword;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      bigimg,
                      height: height = 350,
                      width: width = 392.9,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: height = 355,
                      width: width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              stops: [0.3, 0.9],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.white])),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Text(
                      AppName,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Center(
                    child: Text(
                      Slogan,
                      style: TextStyle(
                          fontSize: 18.6,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(239, 161, 113, 0.886)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 1),
                  child: Container(
                    child: Text(
                      "  $CreateAcc",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          primaryColor.withOpacity(0.3),
                          primaryColor.withOpacity(0.0),
                          Colors.transparent,
                        ]),
                        border: Border(
                            left: BorderSide(color: primaryColor, width: 4))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    onSaved: (value) {
                      _email = value!;
                    },
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "Please Enter Email";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email)) {
                        return "Invalid Email Format";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        prefixIcon: Icon(
                          Icons.email,
                          color: primaryColor,
                        ),
                        labelText: "EMAIL ADDRESS",
                        labelStyle:
                            TextStyle(color: primaryColor, fontSize: 17)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TextFormField(
                    obscureText: true,
                    onSaved: (value) {
                      _password = value!;
                    },
                    validator: (password) {
                      if (password!.isEmpty) {
                        return "Please Enter Password";
                      } else if (password.length < 8) {
                        return "Password should be at least 8 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        prefixIcon: Icon(
                          Icons.remove_red_eye,
                          color: primaryColor,
                        ),
                        labelText: "PASSWORD",
                        labelStyle:
                            TextStyle(color: primaryColor, fontSize: 17)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TextFormField(
                    obscureText: true,
                    onSaved: (Value) {
                      _repassword = Value!;
                    },
                    validator: (repassword) {
                      if (repassword!.isEmpty) {
                        return "Please Confirm Password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        prefixIcon: Icon(
                          Icons.remove_red_eye,
                          color: primaryColor,
                        ),
                        labelText: "CONFIRM PASSWORD",
                        labelStyle:
                            TextStyle(color: primaryColor, fontSize: 17)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: height = 50,
                      width: width = 300,
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 250, 97, 1),
                            ),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18.0)))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            // Check if passwords match
                            if (_password == _repassword) {
                              // Navigate to the login page
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('account created'),
                                  backgroundColor: primaryColor,
                                  duration: Duration(seconds: 4),
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            } else {
                              // Display an error message for password mismatch
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Passwords do not match!'),
                                  backgroundColor: primaryColor,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                        child: Text(
                          "Create account",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
