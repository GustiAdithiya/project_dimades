// ignore_for_file: prefer_const_constructors, deprecated_member_use, empty_catches

import 'package:dimades_project/konstant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'build_text_field.dart';

class EditPage extends StatefulWidget {
  final String nama, alamat, instansi, telp, email, id;
  const EditPage({
    Key key,
    this.nama,
    this.alamat,
    this.instansi,
    this.telp,
    this.email,
    this.id,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController instansi = TextEditingController();
  TextEditingController telp = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    nama.text = widget.nama;
    alamat.text = widget.alamat;
    instansi.text = widget.instansi;
    telp.text = widget.telp;
    email.text = widget.email;
  }

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  _createAccount(String id) async {
    String params = '/api/update/$id';
    var url = Uri.http(cUrl, params);
    Map<String, String> body = {
      "name": nama.text,
      "email": email.text,
      "address": alamat.text,
      "telp": telp.text,
      "instansi": instansi.text,
    };
    try {
      final response = await http.post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
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
        title: Text("Edit Profil"),
      ),
      key: _scaffold,
      body: SingleChildScrollView(
        // reverse: true,
        child: Container(
          height: size.height,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.black.withRed(100)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Form(
                      key: _form,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            BuildTextField(
                              control: nama,
                              hint: "Hanya Contoh",
                              label: "Nama Lengkap",
                              icon: Icons.person,
                              validasi: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Nama Lengkap cannot be empty';
                                }
                              },
                              input: TextInputType.name,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BuildTextField(
                              control: email,
                              hint: "contoh@example.com",
                              label: "Email",
                              icon: Icons.email,
                              validasi: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Email cannot be empty';
                                }
                              },
                              input: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BuildTextField(
                              control: telp,
                              hint: "08xxxxxxxxxx",
                              label: "Telephone",
                              icon: Icons.call,
                              validasi: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Telephone cannot be empty';
                                }
                              },
                              input: TextInputType.phone,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BuildTextField(
                              control: alamat,
                              hint: "Indramayu, Jawa Barat",
                              label: "Address",
                              icon: Icons.location_on,
                              validasi: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Nama Lengkap cannot be empty';
                                }
                              },
                              input: TextInputType.text,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BuildTextField(
                              control: instansi,
                              hint: "Instansi",
                              label: "Instansi",
                              icon: Icons.business_outlined,
                              validasi: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Instansi cannot be empty';
                                }
                              },
                              input: TextInputType.text,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // NOTE: BUTTON REGISTER
                            SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  final isValid = _form.currentState.validate();
                                  if (!isValid) {
                                    return;
                                  } else {
                                    _createAccount(widget.id);
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
                                        borderRadius:
                                            BorderRadius.circular(17))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
