// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_element

import 'dart:convert';

import 'package:dimades_project/home/komponents/selengkapnya_page.dart';
import 'package:dimades_project/konstant.dart';
import 'package:dimades_project/models/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Category> categoryList = [];
  bool ktgr = true;
  String idk, title;

  @override
  void initState() {
    super.initState();
    fetchKategori(idk);
  }

  @override
  void dispose() {
    super.dispose();
    categoryList = [];
  }

  Future<List<Category>> fetchKategori(String id) async {
    List<Category> usersList = [];
    categoryList = [];
    Uri url;
    if (ktgr) {
      var params = "/api/mainCategory";
      url = Uri.http(cUrl, params);
    } else {
      var params = "/api/subCategory";
      url = Uri.http(cUrl, params + "/$id");
    }

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Category>((json) {
          return Category.fromJson(json);
        }).toList();
        setState(() {
          categoryList = usersList;
        });
      }
    } catch (e) {
      usersList = categoryList;
    }
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categori Product",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ktgr ? _kategori() : _subkategori(),
    );
  }

  Widget _kategori() {
    return Container(
      color: Colors.white54,
      child: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) => Card(
          child: InkWell(
            onTap: () {
              setState(() {
                ktgr = !ktgr;
                title = categoryList[index].name;
                idk = categoryList[index].id.toString();
                fetchKategori(idk);
              });
            },
            child: ListTile(
              leading: Icon(Icons.label),
              title: Text(categoryList[index].name),
              trailing: Icon(Icons.arrow_right_sharp),
            ),
          ),
        ),
      ),
    );
  }

  Widget _subkategori() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              ktgr = !ktgr;
              fetchKategori("");
            });
          },
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(0, 1),
                    ),
                  ]),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SelengkapnyaPage(
                          title: title,
                          id: idk,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Lihat Semua Produk",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: primaryColor),
                  )),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categoryList.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: Icon(Icons.label),
                  title: Text(categoryList[index].name),
                  trailing: Icon(Icons.arrow_right_sharp),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SelengkapnyaPage(
                          title: categoryList[index].name,
                          id: categoryList[index].id.toString(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
