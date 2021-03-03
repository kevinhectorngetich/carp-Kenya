import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class BookRead extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[600],
          elevation: 4.0,
          toolbarHeight: 60,
          title: Text(data['Title']),
          centerTitle: true,
        ),
        body: Center(
          child: PDF.network('http://bumho.pythonanywhere.com' + data['File']),
          widthFactor: 370,
          heightFactor: 740,
        ));
  }
}
