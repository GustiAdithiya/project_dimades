// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:dimades_project/akun/komponents/ubah_password_page.dart';
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
    Size size = MediaQuery.of(context).size;
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
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withRed(50).withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
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
                                                color:
                                                    Colors.black.withRed(100),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                          ),
                                        ))
                                  ],
                                ),
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
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
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black.withRed(100),
                                    )),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withRed(50).withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ]),
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: SizedBox(
                              width: size.width * 0.7,
                              child: Row(
                                children: [
                                  Text(
                                    "Alamat : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data[0].address),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: SizedBox(
                              width: size.width * 0.7,
                              child: Row(
                                children: [
                                  Text(
                                    "Phone : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data[0].telp),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: SizedBox(
                              width: size.width * 0.7,
                              child: Row(
                                children: [
                                  Text("Instansi : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(snapshot.data[0].instansi),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                BuildButton(
                  title: "Change Password",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UbahPasswordPage(
                          id: widget.userid,
                        ),
                      ),
                    );
                  },
                  icon: Icons.edit,
                  icolor: Colors.black.withRed(100),
                  bcolor: Colors.white,
                  tcolor: Colors.black.withRed(100),
                ),
                SizedBox(height: 10),
                BuildButton(
                  title: "Logout",
                  press: () {
                    _onAlertButtonsPressed(context);
                  },
                  icon: Icons.logout,
                  icolor: Colors.white,
                  bcolor: Colors.black.withRed(100),
                  tcolor: Colors.white,
                ),
              ],
            );
          }),
    );
  }
}
