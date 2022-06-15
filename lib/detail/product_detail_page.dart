// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'dart:io';
import 'package:dimades_project/login/login_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:dimades_project/konstant.dart';
import 'package:dimades_project/models/product.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'komponent/body.dart';
import 'package:http/http.dart' as http;

class ProductDetailPage extends StatefulWidget {
  final int id;
  final String name, description, path, mitra;

  const ProductDetailPage(
      {Key key, this.id, this.name, this.description, this.path, this.mitra})
      : super(key: key);
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<Product> productList = [];
  String cid;
  bool visible = false;
  bool login = false;

  @override
  void initState() {
    super.initState();
    cekLogin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getBool('login') ?? false;
      cid = prefs.getString('cid') ?? "";
    });
    _cek(cid, widget.id.toString());
  }

  File selectedfile;
  String progress;
  selectFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        selectedfile = File(result.files.single.path);
      });
    } //update the UI so that file name is shown
  }

  uploadFile(String pid, String cid) async {
    String params = '/api/makeContract';
    var url = Uri.http(cUrl, params);

    var request = http.MultipartRequest("POST", url);

    request.fields['product_id'] = pid.toString();
    request.fields['customer_id'] = cid.toString();
    request.fields['status'] = "0";

    var file = await http.MultipartFile.fromPath('file', selectedfile.path);

    request.files.add(file);
  }

  String cek = "";
  _cek(String cid, String pid) async {
    var params = "/api/cek";
    var url = Uri.http(cUrl, params + "/" + cid + "&" + pid);
    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        if (res.body == "OK") {
          setState(() {
            cek = "true";
          });
        } else {
          setState(() {
            cek = "false";
          });
        }
      }
    } catch (e) {
      setState(() {
        cek = "false";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Detail Product"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Body(
              id: widget.id,
              name: widget.name,
              description: widget.description,
              path: widget.path,
              mitra: widget.mitra,
            ),
          ),
          Visibility(
            visible: visible,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 220,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: selectedfile == null
                                    ? Text(
                                        "Choose File",
                                        textAlign: TextAlign.justify,
                                      )
                                    : Center(
                                        child: Text(
                                          basename(selectedfile.path),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                              ),
                              RaisedButton.icon(
                                onPressed: selectFile,
                                icon: Icon(Icons.folder_open),
                                label: Text("CHOOSE FILE"),
                                color: Colors.redAccent,
                                colorBrightness: Brightness.dark,
                              ),
                              selectedfile == null
                                  ? Container()
                                  : RaisedButton.icon(
                                      onPressed: () {
                                        uploadFile(widget.id.toString(), cid);
                                        _onAlertButtonPressed(
                                            context,
                                            AlertType.success,
                                            "SUCCESS",
                                            "Berhasil Membuat Kontrak");
                                      },
                                      icon: Icon(Icons.folder_open),
                                      label: Text("UPLOAD FILE"),
                                      color: Colors.redAccent,
                                      colorBrightness: Brightness.dark,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          height: 60,
          padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                color: Colors.grey[100],
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  height: 50,
                  width: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: primaryColor,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.call,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (login) {
                          if (cek == "true") {
                            setState(() {
                              visible = !visible;
                            });
                          }
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        }
                      },
                      child: cek == ""
                          ? Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircularProgressIndicator(),
                            )
                          : Text('Kontrak',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          primary: cek == "true"
                              ? Colors.black.withRed(100)
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onAlertButtonPressed(context, type, title, desc) {
    Alert(
      context: context,
      type: type,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              visible = !visible;
            });
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }
}
