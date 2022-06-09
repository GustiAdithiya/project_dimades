// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables

import 'package:dimades_project/detail/product_detail_page.dart';
import 'package:dimades_project/konstant.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  final int id;
  final String name, shortdes, mitra, path, description;
  const ItemList(
      {Key key,
      this.name,
      this.shortdes,
      this.mitra,
      this.path,
      this.id,
      this.description})
      : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
              builder: (context) => ProductDetailPage(
                    id: widget.id,
                    name: widget.name,
                    description: widget.description,
                    mitra: widget.mitra,
                    path: widget.path,
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
            ]),
        width: double.infinity,
        height: 140,
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 110,
                      child: widget.path != ""
                          ? Image.network(
                              _buildImage(widget.path),
                              fit: BoxFit.fill,
                            )
                          : Center(
                              child: Icon(
                              Icons.image_not_supported,
                            )),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.shortdes,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Icon(Icons.person, size: 20),
                                Text(widget.mitra,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5))),
                              ],
                            ),
                          ],
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

  String _buildImage(String path) {
    var url = Uri.http(cUrl, "/storage/$path");
    return url.toString();
  }
}
