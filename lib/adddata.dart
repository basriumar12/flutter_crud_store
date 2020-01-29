import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud_store/constant.dart';
import 'package:http/http.dart' as http;
import 'constant.dart' as util;
import 'constant.dart';
import 'package:flushbar/flushbar.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerCode = new TextEditingController();
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerPrice = new TextEditingController();
  TextEditingController controllerStock = new TextEditingController();

  void addData() {
    var url = "${Constant.url}adddata.php";
    Map<String, String> mRequest = {
      "itemcode": controllerCode.text,
      "itemname": controllerName.text,
      "price": controllerPrice.text,
      "stock": controllerStock.text
    };

    util.httpPost(url, mRequest).then((data) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          var hasil = json.encode(data);
          print('data add ${hasil}');
          print('url ${url} and param ${mRequest}');
        });
      });
    });
  }

  void showSnackBar(String message, {Color color = Colors.red}) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      backgroundColor: color,
      overlayColor: Colors.white,
      duration: Duration(seconds: 4),
    )..show(context);

    print("dalam flushbar");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ADD DATA"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  keyboardType: TextInputType.number,
                  controller: controllerCode,
                  decoration: new InputDecoration(
                      hintText: "Item Code", labelText: "Item Code"),
                ),
                new TextField(
                  controller: controllerName,
                  decoration: new InputDecoration(
                      hintText: "Item Name", labelText: "Item Name"),
                ),
                new TextField(
                  keyboardType: TextInputType.number,
                  controller: controllerPrice,
                  decoration: new InputDecoration(
                      hintText: "Price", labelText: "Price"),
                ),
                new TextField(
                  keyboardType: TextInputType.number,
                  controller: controllerStock,
                  decoration: new InputDecoration(
                      hintText: "Stock", labelText: "Stock"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("ADD DATA"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (controllerCode.text.toString().isEmpty ||
                        controllerName.text.toString().isEmpty ||
                        controllerPrice.text.toString().isEmpty ||
                        controllerStock.text.toString().isEmpty) {
                      showSnackBar('ada field yang kosong');
                    } else {
                      addData();
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
