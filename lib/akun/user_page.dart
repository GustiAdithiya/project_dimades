// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dimades_project/akun/komponents/user_login.dart';
import 'package:dimades_project/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool login = false;
  String uid, cid;

  cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getBool('login') ?? false;
      cid = prefs.getString('cid') ?? "";
      uid = prefs.getString('uid') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    cekLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withRed(100),
        title: Text("Profil"),
      ),
      body: !login ? LoginPage() : UserLogin(userid: uid),
    );
    // body: UserLogin(),
  }
}
