

import 'package:carp_kenya/book_read.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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
    //downloadFile(pdfUrl);
  }
  String progressString = "";
  bool downloading = false;
  Future<void> downloadFile(pdfUrl, pdfname) async{
    Dio dio = Dio();
    try{
      final status = await Permission.storage.request();
      if(status.isGranted){
      var dir = await getExternalStorageDirectory();
      
      await dio.download(pdfUrl, "${dir.path}/$pdfname.pdf", onReceiveProgress: (rec, total){
        print("REc: $rec, Total: $total");
        setState(() {
          progressString = ((rec/total) * 100).toStringAsFixed(0) + "%";
        });

      });
      }
    }
    catch (e){
      print(e);
    }
    setState(() {
      progressString="Download Completed";
      print("Download Complete");
      downloading = false;
    });
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
                          onPressed: () async{
                            downloading = true;                            
                            
                            // final status = await Permission.storage.request();
                            // if(status.isGranted){
                            //   debugPrint(data['File']);
                            //   print('-------------'+data['File']);

                              downloadFile(pdfUrl, data['Title']);

                              // final externalDir = await getApplicationDocumentsDirectory();

                              //  await FlutterDownloader.enqueue(
                              //  //url: "http://bumho.pythonanywhere.com/media/Mother_of_Peace__A_Memoir_by_Ha_-_Hak_Ja_Han_Moon.pdf",
                               
                              //  //url: "https://raw.githubusercontent.com/FlutterInThai/Dart-for-Flutter-Sheet-cheet/master/Dart-for-Flutter-Cheat-Sheet.pdf",
                              //  url: 'http://bumho.pythonanywhere.com' + data['File'],
                              //  savedDir: externalDir.path,
                              //  fileName: data['Title'],
                              //  showNotification: true,
                              //  openFileFromNotification: true,
                              //  );
                            
                          }),
                    ),
                  ],
                ),
                downloading ? CircularProgressIndicator() : Text(""),
                SizedBox(height: 20.0,),
                downloading? Text("Downloading File: $progressString") : Text(""),
              ],
            )),
      ),
    );
  }
}

class Downloading extends StatefulWidget {
  Downloading({Key key}) : super(key: key);

  @override
  _DownloadingState createState() => _DownloadingState();
}

class _DownloadingState extends State<Downloading> {
 //PermissionHandler  permissionHandler = PermissionHandler()
  @override
  void initState() {
    super.initState();
    this.getPermissions();
  }

  void getPermissions() async {
    //print('Permission');
    //await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
