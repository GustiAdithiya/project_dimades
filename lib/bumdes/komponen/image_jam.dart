// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ImageJam extends StatelessWidget {
  const ImageJam({
    Key key,
    @required this.size,
    @required this.tanggal,
    @required this.jam,
  }) : super(key: key);

  final Size size;
  final String tanggal;
  final String jam;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      width: size.width,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: _image(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 40,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tanggal),
                    Text(
                      jam,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return Image.asset(
      "assets/baldes.jpeg",
      height: 300.0,
      width: size.width,
      fit: BoxFit.cover,
    );
  }
}
