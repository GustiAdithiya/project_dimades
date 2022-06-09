// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class VisiMisi extends StatelessWidget {
  const VisiMisi({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Visi & Misi",
              style: TextStyle(
                  color: Colors.black.withRed(80),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "VISI",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "1. Meningkatkan usaha masyarakat dalam pengelolaan potensi ekonomi desa.",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                          "2. Meningkatkan pendapatan masyarakat desa dan Pendapatan Asli Desa",
                          textAlign: TextAlign.center)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "MISI",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Mengelola dana program yang masuk ke Desa bersifat dana berguir terutama dalam rangka mengentaskan kemiskinan dan pengembangan usaha ekonomi pedesaan.",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
