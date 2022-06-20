// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, missing_return, deprecated_member_use, empty_catches
import 'package:dimades_project/konstant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'build_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  TextEditingController telp = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController instansi = TextEditingController();

  bool _isObpass = true;
  bool _isObcpass = true;

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  _createAccount() async {
    String params = '/api/register';
    var url = Uri.http(cUrl, params);
    Map<String, String> body = {
      "name": name.text,
      "email": email.text,
      "password": pass.text,
      "role": "0",
      "address": address.text,
      "telp": telp.text,
      "instansi": instansi.text,
    };
    try {
      final response = await http.post(
        url,
        body: body,
      );
      if (response.statusCode == 201) {
        _scaffold.currentState.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text("Registration Success",
              style: TextStyle(color: Colors.black)),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.white,
        ));
        setState(() {
          name.text = "";
          telp.text = "";
          pass.text = "";
          cpass.text = "";
          email.text = "";
          address.text = "";
          instansi.text = "";
        });
      } else {
        _scaffold.currentState.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content:
              Text("Registration Gagal", style: TextStyle(color: Colors.black)),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.white,
        ));
        setState(() {
          name.text = "";
          telp.text = "";
          pass.text = "";
          cpass.text = "";
          email.text = "";
          address.text = "";
          instansi.text = "";
        });
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
          elevation: 0,
          title: Text(
            "REGISTRASI",
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        key: _scaffold,
        body: SingleChildScrollView(
          // reverse: true,
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.black.withRed(100)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Form(
                            key: _form,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: BuildTextField(
                                      con: name,
                                      hint: "Hanya Contoh",
                                      label: "Nama Lengkap",
                                      icon: Icons.person,
                                      validasi: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Nama Lengkap cannot be empty';
                                        }
                                      },
                                      input: TextInputType.name,
                                      color: Colors.black.withRed(100),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: BuildTextField(
                                      con: email,
                                      hint: "contoh@example.com",
                                      label: "Email",
                                      icon: Icons.email,
                                      validasi: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Email cannot be empty';
                                        }
                                      },
                                      input: TextInputType.emailAddress,
                                      color: Colors.black.withRed(100),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: BuildTextField(
                                      con: telp,
                                      hint: "08xxxxxxxxxx",
                                      label: "Telephone",
                                      icon: Icons.call,
                                      validasi: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Telephone cannot be empty';
                                        }
                                      },
                                      input: TextInputType.phone,
                                      color: Colors.black.withRed(100),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: BuildTextField(
                                      con: address,
                                      hint: "Indramayu, Jawa Barat",
                                      label: "Address",
                                      icon: Icons.location_on,
                                      validasi: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Nama Lengkap cannot be empty';
                                        }
                                      },
                                      input: TextInputType.name,
                                      color: Colors.black.withRed(100),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: BuildTextField(
                                      con: instansi,
                                      hint: "Instansi",
                                      label: "Instansi",
                                      icon: Icons.business_outlined,
                                      validasi: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Instansi cannot be empty';
                                        }
                                      },
                                      input: TextInputType.text,
                                      color: Colors.black.withRed(100),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: TextFormField(
                                      controller: pass,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'password cannot be empty';
                                        } else if (text.length < 8) {
                                          return "Enter valid password of more then 8 characters!";
                                        }
                                      },
                                      obscureText: _isObpass,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black.withRed(100),
                                              width: 2,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black.withRed(100),
                                              width: 2,
                                            )),
                                        hintText: "Password",
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                          color: Colors.black.withRed(100),
                                        ),
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.black.withRed(100)),
                                        suffixIcon: IconButton(
                                          icon: _isObpass
                                              ? Icon(
                                                  Icons.visibility,
                                                  color:
                                                      Colors.black.withRed(100),
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color:
                                                      Colors.black.withRed(100),
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
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: TextFormField(
                                      controller: cpass,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Confirm password cannot be empty';
                                        } else if (text != pass.text) {
                                          return "Password doesn't match";
                                        }
                                      },
                                      obscureText: _isObcpass,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black.withRed(100),
                                              width: 2,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                  color:
                                                      Colors.black.withRed(100),
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color:
                                                      Colors.black.withRed(100),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: SizedBox(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          final isValid =
                                              _form.currentState.validate();
                                          if (!isValid) {
                                            return;
                                          } else {
                                            _createAccount();
                                          }
                                        },
                                        child: Text('Register',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white)),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.black.withRed(100),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(17))),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Sudah Punya Akun?",
                                          style: TextStyle(fontSize: 18)),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(" Masuk",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color:
                                                    Colors.black.withRed(100))),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            )),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}
