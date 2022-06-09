// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';

import 'package:dimades_project/konstant.dart';
import 'package:dimades_project/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'komponents/category_page.dart';
import 'komponents/item_list.dart';
import 'komponents/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Product> searchresult = [];
  List<Product> productList = [];
  TabController _tabController;

  Future<List<Product>> fetchProduct() async {
    List<Product> usersList;
    var params = "/api/product";
    var url = Uri.http(cUrl, params);
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

  Icon icon = Icon(
    Icons.search,
    color: primaryColor,
  );

  final globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  _HomePageState() {
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
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {});
    _isSearching = false;
    fetchProduct();
  }

  Future<void> _refresh() {
    return fetchProduct().then((_kategori) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: _isSearching || _controller.text != ""
          ? SedangSearching(context)
          : TidakSearching(),
    );
  }

  RefreshIndicator SedangSearching(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(bottom: 7),
        child: FutureBuilder<List<Product>>(
          future: fetchProduct(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return Container(
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
            );
          },
        ),
      ),
    );
  }

  TidakSearching() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: [
        ProductPage(),
        CategoryPage(),
      ],
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        labelPadding: EdgeInsets.all(0),
        tabs: [
          Tab(text: "Beranda"),
          Tab(text: "Kategori"),
        ],
      ),
      title: InkWell(
        onTap: () {
          setState(() {
            if (icon.icon == Icons.search) {
              icon = Icon(
                Icons.close,
                color: primaryColor,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
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
        color: primaryColor,
      );
      _isSearching = false;
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
