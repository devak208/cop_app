import 'package:cop_app/LoginScreen.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(InitialScreen());
}

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      title: AppName,
      debugShowCheckedModeBanner: false,
    );
  }
}
