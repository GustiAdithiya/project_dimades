// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, missing_return

import 'dart:convert';

import 'package:dimades_project/detail/product_detail_page.dart';
import 'package:dimades_project/home/komponents/selengkapnya_page.dart';
import 'package:dimades_project/konstant.dart';
import 'package:dimades_project/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WidgetByCategory extends StatefulWidget {
  final Widget child;
  final int id;
  final String category;

  const WidgetByCategory(this.id, this.category, {Key key, this.child})
      : super(key: key);

  @override
  _WidgetByCategoryState createState() => _WidgetByCategoryState();
}

class _WidgetByCategoryState extends State<WidgetByCategory> {
  List<Product> productList = [];

  Future<List<Product>> fetchProduct(var idCategory) async {
    List<Product> usersList;
    var params = "/api/productCategory";
    var url = Uri.http(cUrl, params + "/$idCategory");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Product>((json) {
          return Product.fromJson(json);
        }).toList();
        setState(() {
          productList = usersList;
        });
      }
    } catch (e) {
      usersList = productList;
    }
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(right: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.category,
                    style: TextStyle(color: Colors.white),
                  ),
                  width: size.width * 0.4,
                  height: 30,
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    color: primaryColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SelengkapnyaPage(
                          title: widget.category,
                          id: widget.id.toString(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Selengkapnya",
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 260,
            margin: EdgeInsets.only(bottom: 7),
            child: widget.id == null
                ? CircularProgressIndicator()
                : FutureBuilder<List<Product>>(
                    future: fetchProduct(widget.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) => Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                    builder: (context) => ProductDetailPage(
                                          id: snapshot.data[i].id,
                                          name: snapshot.data[i].name,
                                          description:
                                              snapshot.data[i].description,
                                          mitra: snapshot.data[i].mitra,
                                          path: snapshot.data[i].path,
                                        )),
                              );
                            },
                            child: Container(
                              width: size.width / 1.5,
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
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 170,
                                      width: size.width / 1.5,
                                      child: snapshot.data[i].path != ""
                                          ? Image.network(
                                              _buildImage(
                                                  snapshot.data[i].path),
                                              fit: BoxFit.fill,
                                            )
                                          : Center(
                                              child: Icon(
                                                Icons.image_not_supported,
                                              ),
                                            ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data[i].name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Text("by: " + snapshot.data[i].mitra),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _buildImage(String path) {
    var url = Uri.http(cUrl, "/storage/$path");
    return url.toString();
  }
}
