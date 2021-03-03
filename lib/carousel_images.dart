import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_pro/carousel_pro.dart';

class CarouselHome extends StatelessWidget {
  const CarouselHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
      child: SizedBox(
        height: 250.0,
        width: double.infinity,
        child: Carousel(dotSize: 4, dotBgColor: Colors.transparent, images: [
          Image.asset(
            "assets/home.JPG",
            height: 200,
            fit: BoxFit.cover,
          ),
          Image.asset(
            "assets/carp1.jpg",
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Image.asset(
            "assets/image1.png",
            height: 200.0,
            fit: BoxFit.cover,
          ),
        ]),
      ),
    );
  }
}
