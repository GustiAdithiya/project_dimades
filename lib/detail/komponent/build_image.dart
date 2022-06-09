// ignore_for_file: prefer_const_constructors

import 'package:dimades_project/konstant.dart';
import 'package:flutter/material.dart';

class BuildImage extends StatelessWidget {
  final String url;
  const BuildImage({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 300.0,
      width: size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: url != ""
            ? Image.network(
                _buildImage(url),
                fit: BoxFit.fill,
              )
            : Center(
                child: Icon(
                Icons.image_not_supported,
              )),
      ),
    );
  }

  String _buildImage(String path) {
    var url = Uri.http(cUrl, "/storage/$path");
    return url.toString();
  }
}
