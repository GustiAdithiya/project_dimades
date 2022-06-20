// ignore_for_file: prefer_const_constructors, missing_return

import 'package:dimades_project/konstant.dart';
import 'package:dimades_project/launcher.dart';
import 'package:flutter/material.dart';

class ChangeIP extends StatefulWidget {
  const ChangeIP({Key key}) : super(key: key);

  @override
  State<ChangeIP> createState() => _ChangeIPState();
}

class _ChangeIPState extends State<ChangeIP> {
  final _form = GlobalKey<FormState>();
  TextEditingController ip = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("IP CONFIG",
                  style: TextStyle(
                      color: Colors.black.withRed(100),
                      fontWeight: FontWeight.bold,
                      fontSize: 28)),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  style: TextStyle(color: Colors.black.withRed(100)),
                  controller: ip,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'IP cannot be empty';
                    }
                  },
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
                    focusColor: Colors.black.withRed(100),
                    labelText: "IP Addres",
                    hintText: '192.168.0.0',
                    labelStyle: TextStyle(
                      color: Colors.black.withRed(100),
                    ),
                    prefixIcon:
                        Icon(Icons.lock, color: Colors.black.withRed(100)),
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
                        setState(() {
                          cUrl = ip.text;
                        });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => LauncherPage(),
                          ),
                        );
                      }
                    },
                    child: Text('OK',
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
            ],
          ),
        ),
      ),
    );
  }
}
