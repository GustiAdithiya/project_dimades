// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'build_image.dart';

class Body extends StatefulWidget {
  final int id;
  final String name, description, mitra, path;
  const Body(
      {Key key, this.id, this.name, this.description, this.mitra, this.path})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BuildImage(url: widget.path),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.person),
                  Text(
                    widget.mitra,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Product Description:",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
