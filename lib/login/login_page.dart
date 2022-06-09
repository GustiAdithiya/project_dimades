// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use

import 'dart:convert';

import 'package:dimades_project/konstant.dart';
import 'package:dimades_project/landing_page.dart';
import 'package:dimades_project/login/register_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'build_textfield.dart';

class LoginPage extends StatefulWidget {
  final String nav;
  const LoginPage({Key key, this.nav}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool _isObpass = true;

  _showAlertDialog(BuildContext context, String e) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(e),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (context) => alert,
    );
  }

  _login() async {
    final prefs = await SharedPreferences.getInstance();
    var params = "/api/login";
    var url = Uri.http(cUrl, params + "/" + email.text + "&" + pass.text);
    var res = await http.get(url);
    if (res.statusCode == 200) {
      print(res.body);
      if (res.body == '"Failed"') {
        _showAlertDialog(context, "Login Failed");
        setState(() {
          email.text = "";
          pass.text = "";
        });
      } else {
        var response = json.decode(res.body);
        prefs.setBool('login', true);
        prefs.setString('uid', response[0]['user_id'].toString());
        prefs.setString('cid', response[0]['customer_id'].toString());

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LandingPage()),
            (route) => false);
      }
    } else {
      _showAlertDialog(context, "Login Failed");
      setState(() {
        email.text = "";
        pass.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.black.withRed(100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    "DIMADES",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Text("Silahkan Masuk Terlebih Dahulu\n",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                Form(
                    key: _form,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: BuildTextField(
                            con: email,
                            hint: "contoh@example.com",
                            label: "Email",
                            icon: Icons.person,
                            input: TextInputType.emailAddress,
                            validasi: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Email cannot be empty';
                              }
                            },
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: pass,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'password cannot be empty';
                              }
                              // else if (text.length < 8) {
                              //   return "Enter valid password of more then 8 characters!";
                              // }
                            },
                            obscureText: _isObpass,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  )),
                              focusColor: Colors.white,
                              hintText: "Password",
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              prefixIcon: Icon(Icons.lock, color: Colors.white),
                              suffixIcon: IconButton(
                                icon: _isObpass
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.white,
                                      ),
                                onPressed: () {
                                  setState(
                                    () {
                                      _isObpass = !_isObpass;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // NOTE: BUTTON LOGIN
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                final isValid = _form.currentState.validate();
                                if (!isValid) {
                                  return;
                                } else {
                                  _login();
                                }
                              },
                              child: Text('Login',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withRed(100))),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17))),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Don’t have an account?",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                              child: Text(" Register",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline)),
                            ),
                          ],
                        ),
                        // SizedBox(height: 10),
                      ],
                    ))
              ],
            )));
  }
}
