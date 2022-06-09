// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AlamatKantor extends StatelessWidget {
  const AlamatKantor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Alamat Kantor",
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
                Text(
                    "Jl. Raya Jatibarang-Arjawinangun No.17 Tulungagung, Kec. Kertasemaya, Kabupaten Indramayu, Jawa Barat"),
                Row(
                  children: [
                    Text(
                      "Phone : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("+62 85745156991"),
                  ],
                ),
                Row(
                  children: [
                    Text("Email : ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("bumdesapastibisa@gmail.com"),
                  ],
                ),
                Row(
                  children: [
                    Text("Kode Pos : ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("45274"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
