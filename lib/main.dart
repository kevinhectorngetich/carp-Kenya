import 'package:carp_kenya/downloads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'Books.dart';
import 'Home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await FlutterDownloader.initialize(
    //debug: true // optional: set false to disable printing logs to console

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Tabs(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  @override
  bool get wantKeepAlive => true;

  final tabs = [
    Center(child: Home()),
    Center(child: Books()),
    Center(child: Downloads()),
  ];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 4,
          selectedItemColor: Colors.cyan[600],
          currentIndex: _currentIndex,
          selectedFontSize: 12,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.house_rounded,
                size: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books_rounded,
                size: 30,
              ),
              label: 'Books',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.folder_rounded,
                size: 30,
              ),
              label: 'Downloads',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
