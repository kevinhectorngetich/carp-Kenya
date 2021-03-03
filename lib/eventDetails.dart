import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        elevation: 4.0,
        toolbarHeight: 60,
        title: Text(data['event']),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  'http://bumho.pythonanywhere.com' + data['image'],
                  height: 400.0,
                  cacheHeight: 320,
                  cacheWidth: 350,
                  excludeFromSemantics: true,
                ),
                ListTile(
                  title: Text(
                    data['description'],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
