// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:dimades_project/akun/user_page.dart';
import 'package:dimades_project/bumdes/bumdespage.dart';
import 'package:dimades_project/kontrak/kontrak_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'home/home_page.dart';
import 'konstant.dart';

class LandingPage extends StatefulWidget {
  final String nav;

  const LandingPage({Key key, this.nav}) : super(key: key);
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _bottomNavCurrentIndex = 0;
  final List<Widget> _container = [
    HomePage(),
    BumdesPage(),
    KontrakPage(),
    UserPage()
  ];

  @override
  void initState() {
    super.initState();
    if (widget.nav == '0') {
      _bottomNavCurrentIndex = 0;
    } else if (widget.nav == '1') {
      _bottomNavCurrentIndex = 1;
    } else if (widget.nav == '2') {
      _bottomNavCurrentIndex = 2;
    } else if (widget.nav == '3') {
      _bottomNavCurrentIndex = 3;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bottomNavCurrentIndex = 0;
  }

  // _logout() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.clear();
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => SearchDesa()));
  // }

  // var alertStyle = AlertStyle(
  //   isCloseButton: false,
  //   isOverlayTapDismiss: true,
  //   animationDuration: Duration(milliseconds: 400),
  //   alertBorder: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     side: BorderSide(
  //       color: Colors.grey,
  //     ),
  //   ),
  //   titleStyle: TextStyle(
  //     color: Colors.red,
  //   ),
  // );

  // _onAlertButtonsPressed(context) {
  //   Alert(
  //     style: alertStyle,
  //     context: context,
  //     type: AlertType.warning,
  //     title: "Logout",
  //     desc: "Apakah Anda Yakin Ingin Keluar ?",
  //     buttons: [
  //       DialogButton(
  //           child: Text(
  //             "OK",
  //             style: TextStyle(color: Colors.white, fontSize: 18),
  //           ),
  //           onPressed: () => _logout(),
  //           color: Colors.green),
  //       DialogButton(
  //         child: Text(
  //           "Cancel",
  //           style: TextStyle(color: Colors.white, fontSize: 18),
  //         ),
  //         onPressed: () => Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => LandingPage())),
  //         color: Colors.red,
  //       )
  //     ],
  //   ).show();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container[_bottomNavCurrentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                onTabChange: (index) {
                  setState(() {
                    _bottomNavCurrentIndex = index;
                  });
                },
                rippleColor: Colors.grey[300],
                hoverColor: Colors.grey[100],
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: primaryColor,
                color: Colors.black, // navigation bar padding
                tabs: const [
                  GButton(
                    icon: Icons.dashboard,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.house_rounded,
                    text: 'BUMDES',
                  ),
                  GButton(
                    icon: Icons.note,
                    text: 'Kontrak',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'User',
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
