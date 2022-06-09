// ignore_for_file: prefer_const_constructors

import 'package:dimades_project/kontrak/komponent/kontrak_login.dart';
import 'package:dimades_project/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KontrakPage extends StatefulWidget {
  const KontrakPage({Key key}) : super(key: key);

  @override
  State<KontrakPage> createState() => _KontrakPageState();
}

class _KontrakPageState extends State<KontrakPage> {
  bool login = false;
  String cid = "";

  @override
  void initState() {
    super.initState();
    cekLogin();
  }

  cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getBool('login') ?? false;
      cid = prefs.getString('cid') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return !login
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black.withRed(100),
              title: Text("Kontrak Saya"),
            ),
            body: LoginPage(),
          )
        : Scaffold(
            body: KontrakLogin(id: cid),
          );
  }
}
