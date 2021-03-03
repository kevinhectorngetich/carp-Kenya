import 'package:carp_kenya/eventDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';

class EventList extends StatefulWidget {
  EventList({
    Key key,
    this.cardings,
  }) : super(key: key);

  final List cardings;

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List data;

  @override
  void initState() {
    super.initState();
    this.getBooks();
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

  @override
  Widget build(BuildContext context) {
    return Events(data: data);
  }
}

class Events extends StatefulWidget {
  const Events({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List data;

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 150,
      margin: EdgeInsets.fromLTRB(2, 5, 5, 1),
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.data == null ? 0 : widget.data.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
          width: 140.0,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventDetails(),
                    settings: RouteSettings(arguments: widget.data[index])),
              );
            },
            child: Card(
              child: Hero(
                tag: widget.data[index]['event'],
                child: Material(
                  child: InkWell(
                    child: GridTile(
                      footer: Container(
                        color: Colors.orange[100],
                        child: ListTile(
                          leading: Text(
                            widget.data[index]['event'] + ':',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                        ),
                      ),
                      child: Image.network(
                        'http://bumho.pythonanywhere.com' +
                            widget.data[index]['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
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
