import 'dart:io' as io;
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_2/pdfviewer.dart';
import 'package:pdf_viewer_2/pdfviewer_scaffold.dart';
import 'package:permission_handler/permission_handler.dart';

class Downloads extends StatefulWidget {
  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  String directory;
  List file = List();

  //getFiles();
  void listofFiles() async {
    String pdfPath = '/storage/emulated/0/CarpDoc';
    Directory directory;
    //directory =(await getExternalStorageDirectory()).path;
    file = io.Directory("$pdfPath").listSync();
    print('-----===>>$file');

    if (file == null) {
      if (await _requestPermission(Permission.storage)) {
        directory = await getExternalStorageDirectory();
        String newPath = "";
        print(directory);
        List<String> paths = directory.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/CarpDoc";
        directory = Directory(newPath);
        print('------newDIR $directory');
        setState(() {
          file = directory.listSync();
        });
      } else {
        setState(() {
          Text('Ooops no downloads');
          CircularProgressIndicator();
          file = io.Directory("$pdfPath").listSync();
        });
      }
    } else {
      if (await _requestPermission(Permission.photos)) {
        directory = await getTemporaryDirectory();
      }
    }

    print('----------------iam beeing executed');
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<void> deleteFile(File dfile) async {
    try {
      final file = dfile;
      await file.delete();
    } catch (e) {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    listofFiles();
  }

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
      body: Container(
        child: ListView.builder(
          itemCount: file.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(file[index].path.split('/').last),
                leading: Icon(
                  Icons.picture_as_pdf,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.lightBlue,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ViewPDF(
                      pathPDF: file[index].path,
                      namePDF: file[index].path.split('/').last,
                    );
                  }));
                },
                onLongPress: () {
                  deleteFile(file[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ViewPDF extends StatelessWidget {
  //final io. File pathPDF;
  final String pathPDF;
  final String namePDF;
  ViewPDF({this.pathPDF, this.namePDF});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PDFViewerScaffold(
            appBar: AppBar(
              title: Text(
                "$namePDF",
                style: TextStyle(fontSize: 20),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
            path: pathPDF),
      ),
    );
  }
}
