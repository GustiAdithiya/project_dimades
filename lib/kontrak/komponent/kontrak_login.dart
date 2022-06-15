// ignore_for_file: prefer_const_constructors, empty_catches

import 'dart:convert';

import 'package:dimades_project/konstant.dart';
import 'package:dimades_project/models/kontrak.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'item_list.dart';

class KontrakLogin extends StatefulWidget {
  final String id;
  const KontrakLogin({Key key, this.id}) : super(key: key);

  @override
  _KontrakLoginState createState() => _KontrakLoginState();
}

class _KontrakLoginState extends State<KontrakLogin> {
  List<Kontrak> kontrakList = [];
  bool isVisible = false;

  Icon icon = Icon(
    Icons.search,
    color: Colors.white,
  );

  final TextEditingController _controller = TextEditingController();
  bool _isSearching;
  List<Kontrak> searchresult = [];

  _KontrakLoginState() {
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
    return fetchKontrak(widget.id.toString());
  }

  klikBatal(int id) async {
    String params = '/api/edit/$id';
    var url = Uri.http(cUrl, params);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _refresh();
        });
      }
    } catch (e) {}
  }

  Future<List<Kontrak>> fetchKontrak(String id) async {
    List<Kontrak> usersList;
    var params = "/api/contract/$id";
    var url = Uri.http(cUrl, params);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Kontrak>((json) {
          return Kontrak.fromJson(json);
        }).toList();
        setState(() {
          kontrakList = usersList;
        });
      }
    } catch (e) {
      usersList = kontrakList;
    }
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<List<Kontrak>>(
            future: fetchKontrak(widget.id.toString()),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data.isEmpty) {
                return const Center(
                  child: Text(
                    "No Record Found",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
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
                                id: snapshot.data[index].id,
                                product_id: searchresult[index].product_id,
                                path: searchresult[index].path,
                                create: searchresult[index].created_at,
                                update: searchresult[index].updated_at,
                                product: searchresult[index].product,
                                st: searchresult[index].status.toString(),
                                image: searchresult[index].image,
                                description: searchresult[index].description,
                                mitra: searchresult[index].mitra);
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
                                product_id: snapshot.data[index].product_id,
                                path: snapshot.data[index].path,
                                create: snapshot.data[index].created_at,
                                update: snapshot.data[index].updated_at,
                                product: snapshot.data[index].product,
                                st: snapshot.data[index].status.toString(),
                                image: snapshot.data[index].image,
                                description: snapshot.data[index].description,
                                mitra: snapshot.data[index].mitra);
                          }),
                    );
            }),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      title: Stack(
        children: [
          Text(
            "Kontrak Saya",
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
      for (var data in kontrakList) {
        if (data.product.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }
}
