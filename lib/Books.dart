import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'List.dart';

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
            onTap: () {},
          ),
          ListTile(
            title: Text('Educational Books'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Inspirational Books'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Drama Books'),
            onTap: () {},
          ),
        ],
      )),
    );
  }
}
