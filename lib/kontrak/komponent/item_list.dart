// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, non_constant_identifier_names, empty_catches

import 'package:dimades_project/detail/product_detail_page.dart';
import 'package:dimades_project/konstant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemList extends StatefulWidget {
  final int id, product_id;
  final String path, image, st, create, update, product, description, mitra;
  const ItemList(
      {Key key,
      this.st,
      this.id,
      this.product_id,
      this.path,
      this.create,
      this.update,
      this.product,
      this.image,
      this.description,
      this.mitra})
      : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  klikBatal(int id) async {
    String params = '/api/edit/$id';
    var url = Uri.http(cUrl, params);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {}
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
              builder: (context) => ProductDetailPage(
                    id: widget.product_id,
                    name: widget.product,
                    description: widget.description,
                    mitra: widget.mitra,
                    path: widget.image,
                  )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        width: double.infinity,
        height: 100,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 0),
                      ),
                    ],
                    color: widget.st == "0"
                        ? Colors.blue
                        : widget.st == "1"
                            ? Colors.blue
                            : widget.st == "2"
                                ? Colors.green
                                : Colors.red,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(5))),
                child: Center(
                  child: Text(
                    widget.st == "0"
                        ? "Wait"
                        : widget.st == "1"
                            ? "Proses"
                            : widget.st == "2"
                                ? "Berhasil"
                                : "Batal",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Icon(
                          Icons.note,
                          size: 30,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Product : " + widget.product,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text("Create At : " + widget.create),
                            Text("Update At : " + widget.update),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.st == "0" ? true : false,
                      child: InkWell(
                        onTap: () {
                          klikBatal(widget.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.red),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.red,
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: Icon(
                              Icons.cancel_sharp,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
