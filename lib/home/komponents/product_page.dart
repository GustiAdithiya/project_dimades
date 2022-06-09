// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';

import 'package:dimades_project/home/komponents/widget_by_kategori.dart';
import 'package:dimades_project/konstant.dart';
import 'package:dimades_project/models/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Category> Categorylist = [];

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  Future<List<Category>> fetchCategory() async {
    List<Category> usersList;
    var params = "/api/mainCategory";
    var url = Uri.http(cUrl, params);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Category>((json) {
          return Category.fromJson(json);
        }).toList();
        setState(() {
          Categorylist = usersList;
        });
      }
    } catch (e) {
      usersList = Categorylist;
    }
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < Categorylist.length; i++)
                  WidgetByCategory(Categorylist[i].id, Categorylist[i].name),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
