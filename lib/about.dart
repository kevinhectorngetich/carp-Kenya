import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class AboutCarp extends StatelessWidget {
  const AboutCarp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text('Who We Are'),
        centerTitle: true,
        backgroundColor: Colors.cyan[600],
      ),
      body: Container(
        child: SizedBox(
          child: Center(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset(
                          "assets/carp.png",
                          height: 200.0,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Cultural Event"),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
