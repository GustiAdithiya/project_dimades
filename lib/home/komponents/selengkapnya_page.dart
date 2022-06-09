// ignore_for_file: prefer_const_constructors, missing_return

import 'dart:convert';

import 'package:dimades_project/konstant.dart';
import 'package:dimades_project/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'item_list.dart';

class SelengkapnyaPage extends StatefulWidget {
  final String title, id;
  const SelengkapnyaPage({Key key, this.title, this.id}) : super(key: key);

  @override
  _SelengkapnyaPageState createState() => _SelengkapnyaPageState();
}

class _SelengkapnyaPageState extends State<SelengkapnyaPage> {
  List<Product> productList = [];
  bool isVisible = false;

  Icon icon = Icon(
    Icons.search,
    color: Colors.white,
  );

  final TextEditingController _controller = TextEditingController();
  bool _isSearching;
  List<Product> searchresult = [];

  _SelengkapnyaPageState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  initState() {
    super.initState();
    _isSearching = false;
  }

  Future<void> _refresh() {
    return fetchProduct(widget.id).then((_kategori) {});
  }

  Future<List<Product>> fetchProduct(String idCategory) async {
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
    return Scaffold(
      appBar: buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          height: size.height,
          margin: EdgeInsets.only(bottom: 7),
          child: FutureBuilder<List<Product>>(
            future: fetchProduct(widget.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return searchresult.isNotEmpty || _controller.text.isNotEmpty
                  ? Container(
                      color: Colors.white70,
                      margin: EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: searchresult.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemList(
                              id: searchresult[index].id,
                              name: searchresult[index].name,
                              shortdes: searchresult[index].short_description,
                              path: searchresult[index].path,
                              mitra: searchresult[index].mitra,
                              description: searchresult[index].description,
                            );
                          }),
                    )
                  : Container(
                      color: Colors.white70,
                      margin: EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemList(
                              id: snapshot.data[index].id,
                              name: snapshot.data[index].name,
                              shortdes: snapshot.data[index].short_description,
                              path: snapshot.data[index].path,
                              mitra: snapshot.data[index].mitra,
                              description: snapshot.data[index].description,
                            );
                          }),
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      title: Stack(
        children: [
          Text(
            "Category: " + widget.title,
            style: TextStyle(color: Colors.white),
          ),
          Visibility(
            visible: isVisible,
            child: TextField(
              controller: _controller,
              onTap: () {},
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.red,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: searchOperation,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: icon,
          onPressed: () {
            setState(
              () {
                if (icon.icon == Icons.search) {
                  icon = Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  isVisible = !isVisible;
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              },
            );
          },
        ),
      ],
    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      icon = Icon(
        Icons.search,
        color: Colors.white,
      );
      isVisible = !isVisible;
      _isSearching = false;
      searchresult = [];
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (var data in productList) {
        if (data.name.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }
}
