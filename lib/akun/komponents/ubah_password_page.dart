// ignore_for_file: prefer_const_constructors, deprecated_member_use, empty_catches, missing_return

import 'package:dimades_project/konstant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UbahPasswordPage extends StatefulWidget {
  final String id;
  const UbahPasswordPage({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  State<UbahPasswordPage> createState() => _UbahPasswordPageState();
}

class _UbahPasswordPageState extends State<UbahPasswordPage> {
  final _form = GlobalKey<FormState>();
  bool _isObopass = true;
  bool _isObcpass = true;
  bool _isObnpass = true;
  TextEditingController npass = TextEditingController();
  TextEditingController opass = TextEditingController();
  TextEditingController cpass = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  _edit(String id) async {
    String params = '/api/password/$id';
    var url = Uri.http(cUrl, params);
    Map<String, String> body = {
      "opass": opass.text,
      "npass": npass.text,
    };
    try {
      final response = await http.post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        if (response.body != '"Fail"') {
          _scaffold.currentState.showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content:
                Text("Update Success", style: TextStyle(color: Colors.black)),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.white,
          ));
          Navigator.pop(context);
        } else {
          _scaffold.currentState.showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content:
                Text("Update Gagal", style: TextStyle(color: Colors.black)),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.white,
          ));
        }
      } else {
        _scaffold.currentState.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text("Update Gagal", style: TextStyle(color: Colors.black)),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.white,
        ));
      }
    } catch (e) {}
    return params;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withRed(100),
        title: Text("Change Password"),
      ),
      key: _scaffold,
      body: Container(
        height: size.height,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.black.withRed(100)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Form(
                  key: _form,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: opass,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'password cannot be empty';
                              } else if (text.length < 8) {
                                return "Enter valid password of more then 8 characters!";
                              }
                            },
                            obscureText: _isObopass,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black.withRed(100),
                                    width: 2,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black.withRed(100),
                                    width: 2,
                                  )),
                              hintText: "Old Password",
                              labelText: 'Old Password',
                              labelStyle: TextStyle(
                                color: Colors.black.withRed(100),
                              ),
                              prefixIcon: Icon(Icons.lock,
                                  color: Colors.black.withRed(100)),
                              suffixIcon: IconButton(
                                icon: _isObopass
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.black.withRed(100),
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.black.withRed(100),
                                      ),
                                onPressed: () {
                                  setState(
                                    () {
                                      _isObopass = !_isObopass;
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: npass,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'password cannot be empty';
                              } else if (text.length < 8) {
                                return "Enter valid password of more then 8 characters!";
                              }
                            },
                            obscureText: _isObnpass,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black.withRed(100),
                                    width: 2,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black.withRed(100),
                                    width: 2,
                                  )),
                              hintText: "New Password",
                              labelText: 'New Password',
                              labelStyle: TextStyle(
                                color: Colors.black.withRed(100),
                              ),
                              prefixIcon: Icon(Icons.lock,
                                  color: Colors.black.withRed(100)),
                              suffixIcon: IconButton(
                                icon: _isObnpass
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.black.withRed(100),
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.black.withRed(100),
                                      ),
                                onPressed: () {
                                  setState(
                                    () {
                                      _isObnpass = !_isObnpass;
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: cpass,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Confirm password cannot be empty';
                              } else if (text != npass.text) {
                                return "Password doesn't match";
                              }
                            },
                            obscureText: _isObcpass,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black.withRed(100),
                                    width: 2,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black.withRed(100),
                                    width: 2,
                                  )),
                              hintText: "Confirm Password",
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                color: Colors.black.withRed(100),
                              ),
                              prefixIcon: Icon(Icons.lock,
                                  color: Colors.black.withRed(100)),
                              suffixIcon: IconButton(
                                icon: _isObcpass
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.black.withRed(100),
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.black.withRed(100),
                                      ),
                                onPressed: () {
                                  setState(
                                    () {
                                      _isObcpass = !_isObcpass;
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
                        // NOTE: BUTTON REGISTER
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                final isValid = _form.currentState.validate();
                                if (!isValid) {
                                  return;
                                } else {
                                  _edit(widget.id);
                                }
                              },
                              child: Text('Update',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black.withRed(100),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
