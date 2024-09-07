import 'package:cop_app/Admin_login%20page.dart';
import 'package:cop_app/HomeScreen.dart';
import 'package:cop_app/Homescreen1.dart';
import 'package:cop_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'colors.dart';
import 'CreateAccount.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(height);
    print(width);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
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
                  padding: const EdgeInsets.all(4.0),
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
                            color: primaryColor),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 1),
                  child: Container(
                      child: Text(
                        "  $logString ",
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
                              left:
                                  BorderSide(color: primaryColor, width: 4)))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    onSaved: (value) {
                      _email = value!;
                      print(_email);
                    },
                    validator: (email) {
                      if (email!.isEmpty)
                        return "Please Enter Email";
                      else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email)) return "Its not a email!";
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
                    onSaved: (value) {
                      _password = value!;
                      print(_password);
                    },
                    validator: (password) {
                      if (password!.isEmpty)
                        return "Please Enter the password";
                      else if (password.length < 8)
                        return 'password length is low';
                    },
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
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
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "forget password",
                            style: TextStyle(fontSize: 15, color: primaryColor),
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: height = 50,
                        width: width = 300,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  primaryColor,
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0)))),
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();
                                if (_email == "test@gmail.com" &&
                                    _password == "Admin@123") {
                                  FocusScope.of(context).unfocus();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Homescreen1(),
                                    ),
                                  );
                                } else {
                                  print("Invalid login details");
                                }
                              }
                            },
                            child: Text(
                              "Login to account",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            )),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateAccountScreen()));
                        },
                        child: Text(
                          "Create account",
                          style: TextStyle(color: primaryColor),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Adminlogin()));
                        },
                        child: Text(
                          "Admin Login?",
                          style: TextStyle(fontSize: 15, color: primaryColor),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
