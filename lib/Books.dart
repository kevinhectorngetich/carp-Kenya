import 'package:carp_kenya/category/action.dart';
import 'package:carp_kenya/category/educational.dart';
import 'package:carp_kenya/category/inpirational.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'List.dart';
import 'category/Unification.dart';

class Books extends StatefulWidget {
  const Books({Key key}) : super(key: key);

  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
   // Map data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        elevation: 4.0,
        toolbarHeight: 70,
        title: Text('Books'),
        centerTitle: true,
      ),
      body: SizedBox(child: CardList()),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.cyan,
            ),
            child: Text(
              'Categories',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Unification Books'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Unification(),
                    //settings: RouteSettings(arguments: data['category']),
                  ));
            },
          ),
          ListTile(
            title: Text('Educational Books'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Educational(),
                    // settings: RouteSettings(arguments: data),
                  ));
            },
          ),
          ListTile(
            title: Text('Inspirational Books'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Inspirational(),
                    // settings: RouteSettings(arguments: data),
                  ));
            },
          ),
          ListTile(
            title: Text('Drama Books'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Drama(),
                    //  settings: RouteSettings(arguments: data),
                  ));
            },
          ),
        ],
      )),
    );
  }
}
