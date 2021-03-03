import 'package:carp_kenya/book_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';


class CardList extends StatefulWidget {
  CardList({Key key, this.cardings}) : super(key: key);

  final List cardings;  

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList>
    with AutomaticKeepAliveClientMixin {

  dynamic data;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    this.getBooks();
  }

  var url = 'http://bumho.pythonanywhere.com/book_json_format/?format=json';

  Future<String> getBooks() async {
    var response = await http.get(url);
    setState(() {
      var convertData = convert.jsonDecode(response.body);
      data = convertData;
    });
    return "Success";
  }
 


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data == null ? 0 : data.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.2),
        width: 180.0,
        child: Card(
          child: Hero(
            tag: data[index]['Title'],
            child: Material(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookDetails(),
                        settings: RouteSettings(arguments: data[index])),
                  );
                },
                child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      title: Text(
                        data[index]['Title'],
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                  child: Image.network(
                    'http://bumho.pythonanywhere.com' +
                        data[index]['imageFile'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
