// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';
import 'dart:core';
import 'package:dimades_project/bumdes/komponen/visi_misi.dart';
import 'package:dimades_project/konstant.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'komponen/alamat_kantor.dart';
import 'komponen/image_jam.dart';

class BumdesPage extends StatefulWidget {
  const BumdesPage({Key key}) : super(key: key);

  @override
  _BumdesPageState createState() => _BumdesPageState();
}

class _BumdesPageState extends State<BumdesPage> {
  var jam = '';
  var tanggal = '';
  void startJam() {
    Timer.periodic(Duration(seconds: 1), (_) {
      var tgl = DateTime.now();
      var formatedjam = DateFormat.Hms().format(tgl);
      var formatedtanggal = DateFormat("EEEE, dd MMMM yyyy").format(tgl);
      if (mounted) {
        setState(() {
          jam = formatedjam;
          tanggal = formatedtanggal;
        });
      }
    });
  }

  @override
  void initState() {
    startJam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile BUMDes",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageJam(
              size: size,
              tanggal: tanggal,
              jam: jam,
            ),
            VisiMisi(),
            AlamatKantor()
          ],
        ),
      ),
    );
  }
}
