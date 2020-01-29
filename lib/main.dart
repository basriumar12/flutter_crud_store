import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud_store/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_crud_store/detail.dart';
import 'package:flutter_crud_store/adddata.dart';

void main() {
  runApp(new MaterialApp(
    title: "My Store",
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<MyApp> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();





  Future<List> getData() async {
    final response = await http.get("${Constant.url}getdata.php");
    print('data url ${Constant.url}getdata.php  ${response.body}');


    return json.decode(response.body);
  }

  Future <List> addData () async{
    var data = await getData();
    List list = List();
    await new Future.delayed(const Duration(seconds: 1));
    list.add(data);
    new ItemList(list:list);



  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
     addData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MY STORE"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  addData();
                  setState(() {

                  });
                },

                child: Icon(
                  Icons.refresh,
                  size: 26.0,
                ),

              )
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: ()=>Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context)=> new AddData(),
            )
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async{
          await Future.delayed(Duration(seconds: 1));
          addData();
          setState(() {
            
          });
        },
        child: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemList(
              list: snapshot.data,
            )
                : new Center(
              child: new CircularProgressIndicator(),
            );
          },
        ),
      )
    );
  }
}



class ItemList extends StatelessWidget {
  // objek dalam bentuk list
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            // tab list menuju ke detail
            onTap: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
                  //parsing data ke detail
                    builder: (BuildContext context)=> new Detail(list:list , index: i,)
                )
            ),
            //set data pada card
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['item_name']),
                leading: new Icon(Icons.dashboard),
                subtitle: new Text("Stock : ${list[i]['stock']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}