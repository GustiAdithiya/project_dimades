// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dimades_project/konstant.dart';
import 'package:dimades_project/landing_page.dart';
import 'package:dimades_project/models/user.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'build_button.dart';
import 'edit_page.dart';

class UserLogin extends StatefulWidget {
  final String userid;
  const UserLogin({Key key, this.userid}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
        (route) => false);
  }

  List<User> userList = [];
  TextEditingController nama, alamat, kota, provinsi, kodepos, telp, email;

  Future<List<User>> fetchUser(String id) async {
    List<User> usersList;
    var params = "/api/customer/$id";
    var url = Uri.http(cUrl, params);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<User>((json) {
          return User.fromJson(json);
        }).toList();
        setState(() {
          userList = usersList;
        });
      }
    } catch (e) {
      usersList = userList;
    }
    return usersList;
  }

  var alertStyle = AlertStyle(
    isCloseButton: false,
    isOverlayTapDismiss: true,
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
  );

  _onAlertButtonsPressed(context) {
    Alert(
      style: alertStyle,
      context: context,
      type: AlertType.warning,
      title: "Logout",
      desc: "Apakah Anda Yakin Ingin Keluar ?",
      buttons: [
        DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () => _logout(),
            color: Colors.green),
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.red,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<User>>(
          future: fetchUser(widget.userid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.black12,
                                    child: ClipOval(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 1,
                                      right: 1,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          child: Icon(
                                            Icons.add_a_photo,
                                            color: Colors.white,
                                            size: 10,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.black.withRed(100),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                        ),
                                      ))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data[0].name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(snapshot.data[0].email),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditPage(
                                          id: widget.userid,
                                          nama: snapshot.data[0].name,
                                          alamat: snapshot.data[0].address,
                                          telp: snapshot.data[0].telp,
                                          instansi: snapshot.data[0].instansi,
                                          email: snapshot.data[0].email,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.black.withRed(100),
                                  )))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                BuildButton(
                  title: "Change Password",
                  press: () {},
                ),
                SizedBox(height: 10),
                BuildButton(
                  title: "Logout",
                  press: () {
                    _onAlertButtonsPressed(context);
                  },
                ),
              ],
            );
          }),
    );
  }
}
