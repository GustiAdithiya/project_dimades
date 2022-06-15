// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  final String title;
  final Function press;
  final IconData icon;
  final Color icolor, bcolor, tcolor;
  const BuildButton({
    Key key,
    this.title,
    this.press,
    this.icon,
    this.icolor,
    this.bcolor,
    this.tcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: press,
          child: Row(
            children: [
              Icon(icon, color: icolor),
              SizedBox(width: 10),
              Text(title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: tcolor)),
            ],
          ),
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.black.withRed(100),
              elevation: 2,
              primary: bcolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
        ),
      ),
    );
  }
}
