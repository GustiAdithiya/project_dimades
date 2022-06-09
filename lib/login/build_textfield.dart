// ignore_for_file: prefer_const_constructors, missing_return

import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    Key key,
    @required this.con,
    @required this.hint,
    @required this.label,
    @required this.icon,
    @required this.validasi,
    @required this.input,
    @required this.color,
  }) : super(key: key);

  final TextEditingController con;
  final String hint, label;
  final IconData icon;
  final Function validasi;
  final TextInputType input;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: input,
      style: TextStyle(color: color),
      controller: con,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: color,
              width: 2,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: color,
              width: 2,
            )),
        focusColor: color,
        hintText: hint,
        labelText: label,
        labelStyle: TextStyle(
          color: color,
        ),
        prefixIcon: Icon(icon, color: color),
      ),
      validator: validasi,
    );
  }
}
