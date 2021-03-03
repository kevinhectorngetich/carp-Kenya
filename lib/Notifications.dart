import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'notification_list.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        elevation: 4.0,
        toolbarHeight: 70,
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: SizedBox(child: NotificationList()),
    );
  }
}
