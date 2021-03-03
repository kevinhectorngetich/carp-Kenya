import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';

class Cards extends StatefulWidget {
  const Cards({Key key}) : super(key: key);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  List data;

  @override
  void initState() {
    super.initState();
    this.getEvents();
  }

  var url = 'http://bumho.pythonanywhere.com/activity_json_format/?format=json';

  Future<String> getBooks() async {
    var response = await http.get(url);
    setState(() {
      var convertData = convert.jsonDecode(response.body);
      data = convertData;
    });
    return "Success";
  }

  getEvents() {
    setState(([index]) {
      return Container(
        child: Card(
          child: Hero(
            tag: data[index]['event'],
            child: Material(
              child: InkWell(
                child: GridTile(
                  footer: Container(
                    color: Colors.orange[100],
                    child: ListTile(
                      leading: Text(
                        data[index]['event'] + ':',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      title: Text(
                        data[index]['description'],
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      ),
                    ),
                  ),
                  child: Image.network(
                    'http://bumho.pythonanywhere.com' + data[index]['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return getEvents();
  }
}
