// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AlamatKantor extends StatelessWidget {
  const AlamatKantor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _launchURL(String url) async {
      if (await launch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Kontak BUMDes",
              style: TextStyle(
                  color: Colors.black.withRed(80),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
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
            child: IntrinsicWidth(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.black.withRed(100),
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.6,
                            child: Text(
                              "Jl. Raya Jatibarang-Arjawinangun No.17 Tulungagung, Kec. Kertasemaya, Kabupaten Indramayu, Jawa Barat 45274",
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _launchURL('https://goo.gl/maps/csNkdTpYTS2BxDkS6');
                        },
                        child: Text(
                          "Maps",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.chat,
                              color: Colors.black.withRed(100),
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.6,
                            child: Text("+62 85745156991"),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _launchURL('https://wa.me/+6285745156991');
                        },
                        child: Text(
                          "Chat",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.email,
                              color: Colors.black.withRed(100),
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.6,
                            child: Text("bumdesapastibisa@gmail.com"),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _launchURL('mailto:bumdesapastibisa@gmail.com');
                        },
                        child: Text(
                          "Mail",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
