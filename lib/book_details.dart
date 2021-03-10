import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:carp_kenya/book_read.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({
    Key key,
  }) : super(key: key);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  void initState() {
    super.initState();
    // downloadFile();
  }

  Dio dio = Dio();
  String progressString = "";
  bool downloading = false;
  double progress = 0;
  Future<bool> downloadFile(pdfUrl, pdfname) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
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
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$pdfname.pdf");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await dio.download(pdfUrl, saveFile.path,
            onReceiveProgress: (rec, total) {
          setState(() {
            progress = rec / total;
            progressString = "Downloading File";
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      setState(() {
        downloading = false;
      });
      return false;
    } catch (e) {
      print(e);
      return false;
    }
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

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    String pdfUrl = 'http://bumho.pythonanywhere.com' + data['File'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        elevation: 4.0,
        toolbarHeight: 60,
        title: Text(data['Title']),
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
                  'http://bumho.pythonanywhere.com' + data['imageFile'],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: RaisedButton(
                          color: Colors.orange[100],
                          child: Text('Read '),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookRead(),
                                  settings: RouteSettings(arguments: data)),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: RaisedButton(
                          color: Colors.orange[100],
                          child: Icon(Icons.file_download),
                          onPressed: () async {
                            downloading = true;
                            progress = 0;
                            downloadFile(pdfUrl, data['Title']);
                            setState(() {
                              progressString = "Download complete";
                            });
                          }),
                    ),
                  ],
                ),
                downloading
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(
                          minHeight: 8.0,
                          value: progress,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(progressString),
                      )
              ],
            )),
      ),
    );
  }
}
