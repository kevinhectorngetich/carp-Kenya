import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'List.dart';

class Downloads extends StatelessWidget {
  const Downloads({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        elevation: 4.0,
        toolbarHeight: 60,
        title: Text('Downloads'),
        centerTitle: true,
      ),
      body: SizedBox(child: CardList()),
    );
  }
}
