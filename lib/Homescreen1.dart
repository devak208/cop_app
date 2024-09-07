import 'package:cop_app/HomeScreen.dart';
import 'package:cop_app/colors.dart';
import 'package:cop_app/com_rules.dart';
import 'package:cop_app/constants.dart';
import 'package:cop_app/fir_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

const Color secondaryColor = Color.fromARGB(255, 40, 167, 69);
const Color backgroundColor = Color.fromARGB(255, 248, 249, 250);

class Homescreen1 extends StatefulWidget {
  const Homescreen1({Key? key}) : super(key: key);

  @override
  State<Homescreen1> createState() => _Homescreen1State();
}

class _Homescreen1State extends State<Homescreen1> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                left: 8.0,
                right: 8.0,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {},
                    iconSize: 30,
                    color: primaryColor,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search here....',
                          suffixIcon: Icon(
                            Icons.search_rounded,
                            color: primaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    _buildIconButton(
                      icon: Icons.description,
                      label: 'file FIR',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                    _buildIconButton(
                      icon: Icons.assignment,
                      label: 'view FIR',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirFormScreen()));
                      },
                    ),
                    _buildIconButton(
                      icon: Icons.error,
                      label: 'emergency',
                      onTap: () {
                        FlutterPhoneDirectCaller.callNumber('+919047021100');
                        /* launch('tel: +919047021100'); */
                      },
                    ),
                    _buildIconButton(
                      icon: Icons.location_on,
                      label: 'Nearby Station',
                      onTap: () {},
                    ),
                    _buildIconButton(
                      icon: Icons.support_agent_outlined,
                      label: 'Help Center',
                      onTap: () {},
                    ),
                    _buildIconButton(
                      icon: Icons.gavel,
                      label: 'Rules',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ComplaintRulesPage()));
                      },
                    ),
                    _buildIconButton(
                      icon: Icons.settings,
                      label: 'Settings',
                      onTap: () {},
                    ),
                    _buildIconButton(
                      icon: Icons.announcement,
                      label: 'Important Info',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  bigimg1,
                  height: 200,
                  width: width - 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    double iconSize = 80,
    double textSize = 16,
    Color textColor = Colors.black,
    FontWeight textWeight = FontWeight.bold,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(icon, size: iconSize),
            color: primaryColor,
            onPressed: onTap,
          ),
          Text(
            label,
            textAlign: textAlign,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: textWeight,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
