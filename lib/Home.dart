import 'package:carp_kenya/Notifications.dart';
import 'package:carp_kenya/about.dart';
import 'package:carp_kenya/eventList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'carousel_images.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Carouselp(),
    );
  }
}

class Carouselp extends StatefulWidget {
  const Carouselp({
    Key key,
  }) : super(key: key);

  @override
  _CarouselpState createState() => _CarouselpState();
}

class _CarouselpState extends State<Carouselp>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        actions: [Nots()],
        backgroundColor: Colors.cyan[600],
        elevation: 4.0,
        toolbarHeight: 60,
        centerTitle: true,
      ),
      body: new ListView(
        padding: EdgeInsets.fromLTRB(1, 5, 1, 0),
        children: <Widget>[
          CarouselHome(),
          EventList(),
          Center(
            widthFactor: 20,
            child: RaisedButton(
                color: Colors.cyan[600],
                child: Text('About CARP-Kenya'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutCarp()),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class Nots extends StatefulWidget {
  Nots({Key key}) : super(key: key);

  @override
  _NotsState createState() => _NotsState();
}

class _NotsState extends State<Nots> {
  List data;

  @override
  void initState() {
    super.initState();
    this.getNots();
  }

  var url =
      'http://bumho.pythonanywhere.com/notification_json_format/?format=json';
  var currentIndex = 0;
  var index = 0;

  Future<String> getNots() async {
    var response = await http.get(url);
    setState(() {
      var convertData = convert.jsonDecode(response.body);
      data = convertData;
    });
    index = data.length;
    return "Success";
  }

  getNumb() {
    if (index != currentIndex) {
      return Container(
        margin: EdgeInsets.all(1),
        child: InkWell(
          onTap: () {
            setState(() {
              index = 0;
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Notifications()));
          },
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Icon(
                Icons.notifications,
                size: 32,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.all(1),
                  width: 18,
                  height: 18,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: Center(
                    child: Text(
                      '$index',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(1),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Notifications()));
          },
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Icon(
                Icons.notifications,
                size: 32,
              ),
            ],
          ),
        ),
      );
    }
  }

  changeBadge() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return getNumb();
  }
}
